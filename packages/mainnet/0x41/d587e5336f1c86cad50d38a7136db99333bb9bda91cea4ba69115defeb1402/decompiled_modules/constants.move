module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::constants {
    public(friend) fun breaking_version_counter() : u64 {
        1
    }

    public(friend) fun day_ms() : u64 {
        86400000
    }

    public(friend) fun default_decimals() : u8 {
        6
    }

    public(friend) fun default_decimals_multiplier() : u64 {
        1000000
    }

    public(friend) fun max_epoch_duration_ms() : u64 {
        86400000
    }

    public(friend) fun max_fee_bps() : u64 {
        100
    }

    public(friend) fun max_oracle_age_ms() : u64 {
        86400000
    }

    public(friend) fun max_peg_price() : u64 {
        10000000
    }

    public(friend) fun max_period_duration_ms() : u64 {
        2592000000
    }

    public(friend) fun max_pyth_confidence_bps() : u16 {
        10000
    }

    public(friend) fun min_amount_usde() : u64 {
        10000
    }

    public(friend) fun min_epoch_duration_ms() : u64 {
        10000
    }

    public(friend) fun min_period_duration_ms() : u64 {
        10000
    }

    public(friend) fun oracle_buffer() : u8 {
        10
    }

    public(friend) fun pyth_oracle_internal_identifier() : vector<u8> {
        b"pyth"
    }

    public(friend) fun second_ms() : u64 {
        1000
    }

    // decompiled from Move bytecode v6
}

