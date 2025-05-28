module 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::constants {
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

    public(friend) fun treasurer_role() : vector<u8> {
        b"TREASURER_ROLE"
    }

    // decompiled from Move bytecode v6
}

