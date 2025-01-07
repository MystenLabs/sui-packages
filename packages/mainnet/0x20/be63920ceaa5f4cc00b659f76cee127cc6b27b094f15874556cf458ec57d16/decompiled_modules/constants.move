module 0x20be63920ceaa5f4cc00b659f76cee127cc6b27b094f15874556cf458ec57d16::constants {
    public(friend) fun fee_precision() : u128 {
        1000000
    }

    public(friend) fun max_bets() : u64 {
        1000
    }

    public(friend) fun max_fee_rate() : u128 {
        10000
    }

    public(friend) fun super_admin_role() : vector<u8> {
        b"SUPER_ADMIN_ROLE"
    }

    // decompiled from Move bytecode v6
}

