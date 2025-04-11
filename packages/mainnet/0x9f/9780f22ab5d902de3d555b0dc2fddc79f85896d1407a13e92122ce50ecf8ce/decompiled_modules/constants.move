module 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants {
    public fun current_version() : u64 {
        2
    }

    public fun max_bps() : u64 {
        10000
    }

    public fun precision_error_allowance() : u64 {
        2
    }

    public fun tx_type_bet() : 0x1::string::String {
        0x1::string::utf8(b"Bet")
    }

    public fun tx_type_win() : 0x1::string::String {
        0x1::string::utf8(b"Win")
    }

    // decompiled from Move bytecode v6
}

