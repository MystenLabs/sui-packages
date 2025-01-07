module 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::constants {
    public(friend) fun fee_precision() : u128 {
        1000000
    }

    public(friend) fun max_bets() : u16 {
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

