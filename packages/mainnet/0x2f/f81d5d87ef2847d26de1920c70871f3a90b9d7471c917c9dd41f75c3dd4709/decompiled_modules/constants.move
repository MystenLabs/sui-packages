module 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants {
    public fun current_version() : u64 {
        1
    }

    public fun head_result() : 0x1::string::String {
        0x1::string::utf8(b"Head")
    }

    public fun house_bias_result() : 0x1::string::String {
        0x1::string::utf8(b"HouseBias")
    }

    public fun initialized_status() : 0x1::string::String {
        0x1::string::utf8(b"Initialized")
    }

    public fun max_house_edge_bps() : u64 {
        10000
    }

    public fun max_payout_factor_bps() : u64 {
        100000000
    }

    public fun max_recent_throws() : u64 {
        10
    }

    public fun new_status() : 0x1::string::String {
        0x1::string::utf8(b"New")
    }

    public fun place_bet_action() : 0x1::string::String {
        0x1::string::utf8(b"PlaceBet")
    }

    public fun settled_status() : 0x1::string::String {
        0x1::string::utf8(b"Settled")
    }

    public fun tail_result() : 0x1::string::String {
        0x1::string::utf8(b"Tail")
    }

    // decompiled from Move bytecode v6
}

