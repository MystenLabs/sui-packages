module 0xa047f4abddbf89b4e30f55151aec286dcb5c9f4201cd20808f0c1b2d8d25ebf3::constants {
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

