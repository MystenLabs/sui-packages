module 0x9ceadc5c4ea0993abe9d5864adcdb0436a45638ea6513fb9ed1fb5cfbfd97d39::constants {
    public fun already_claimed() : u64 {
        5
    }

    public fun invalid_length() : u64 {
        0
    }

    public fun invalid_signature() : u64 {
        6
    }

    public fun invalid_signer() : u64 {
        7
    }

    public fun not_creator() : u64 {
        4
    }

    public fun red_packet_exists() : u64 {
        1
    }

    public fun red_packet_not_active() : u64 {
        3
    }

    public fun red_packet_not_found() : u64 {
        2
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_refunded() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

