-- Create the baby_activities table
CREATE TABLE IF NOT EXISTS baby_activities (
    id UUID PRIMARY KEY,
    type VARCHAR NOT NULL,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE,
    duration VARCHAR,
    amount VARCHAR,
    notes TEXT,
    diaper_type VARCHAR,
    feeding_type VARCHAR,
    nursing_side VARCHAR,
    activity_type VARCHAR,
    user_id VARCHAR NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE
);

-- Create indexes for better query performance
CREATE INDEX idx_baby_activities_user_id ON baby_activities(user_id);
CREATE INDEX idx_baby_activities_created_at ON baby_activities(created_at);

-- Enable Row Level Security
ALTER TABLE baby_activities ENABLE ROW LEVEL SECURITY;

-- Create policy to restrict access to user's own data
CREATE POLICY "Users can only access their own activities"
    ON baby_activities
    FOR ALL
    USING (auth.uid()::text = user_id);

-- Grant access to authenticated users
GRANT ALL ON baby_activities TO authenticated;
GRANT ALL ON baby_activities TO anon;
