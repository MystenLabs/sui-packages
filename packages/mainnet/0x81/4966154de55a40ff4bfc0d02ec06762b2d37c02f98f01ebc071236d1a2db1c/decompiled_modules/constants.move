module 0x78318a056edbfb1c0e9d4a44e82eae3e5c80908852b421b92c6274e9503a17c4::constants {
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

