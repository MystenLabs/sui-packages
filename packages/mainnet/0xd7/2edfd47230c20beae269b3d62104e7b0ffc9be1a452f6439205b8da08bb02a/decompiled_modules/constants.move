module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::constants {
    public(friend) fun admin_min_delay_ms() : u64 {
        43200000
    }

    public(friend) fun auth_min_delay_ms() : u64 {
        21600000
    }

    public(friend) fun grace_period_ms() : u64 {
        604800000
    }

    public(friend) fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

