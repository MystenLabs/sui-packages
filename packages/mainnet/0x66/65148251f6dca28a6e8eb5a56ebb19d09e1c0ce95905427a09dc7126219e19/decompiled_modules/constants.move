module 0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::constants {
    public(friend) fun fee_precision() : u128 {
        1000000
    }

    public(friend) fun max_bets() : u64 {
        1000
    }

    public(friend) fun max_fee_rate() : u128 {
        100000
    }

    public(friend) fun super_admin_role() : vector<u8> {
        b"SUPER_ADMIN_ROLE"
    }

    // decompiled from Move bytecode v6
}

