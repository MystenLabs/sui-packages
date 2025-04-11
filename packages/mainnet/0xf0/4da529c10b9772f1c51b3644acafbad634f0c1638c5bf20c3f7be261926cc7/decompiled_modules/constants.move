module 0xf04da529c10b9772f1c51b3644acafbad634f0c1638c5bf20c3f7be261926cc7::constants {
    public fun advance_action() : 0x1::string::String {
        0x1::string::utf8(b"Advance")
    }

    public fun cash_out_action() : 0x1::string::String {
        0x1::string::utf8(b"CashOut")
    }

    public fun current_version() : u64 {
        1
    }

    public fun empty_position() : u8 {
        255
    }

    public fun game_finished_status() : 0x1::string::String {
        0x1::string::utf8(b"GameFinished")
    }

    public fun game_ongoing_status() : 0x1::string::String {
        0x1::string::utf8(b"GameOngoing")
    }

    public fun initialized_status() : 0x1::string::String {
        0x1::string::utf8(b"Initialized")
    }

    public fun max_payout_factor_bps() : u64 {
        100000000
    }

    public fun max_steps() : u8 {
        50
    }

    public fun new_status() : 0x1::string::String {
        0x1::string::utf8(b"New")
    }

    public fun start_game_action() : 0x1::string::String {
        0x1::string::utf8(b"StartGame")
    }

    // decompiled from Move bytecode v6
}

