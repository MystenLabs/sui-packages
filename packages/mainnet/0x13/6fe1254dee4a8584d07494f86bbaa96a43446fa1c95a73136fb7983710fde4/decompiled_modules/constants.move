module 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::constants {
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

