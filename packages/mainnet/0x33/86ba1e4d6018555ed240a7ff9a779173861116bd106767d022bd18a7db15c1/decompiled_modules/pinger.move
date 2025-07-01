module 0x3386ba1e4d6018555ed240a7ff9a779173861116bd106767d022bd18a7db15c1::pinger {
    public fun get_greeting() : 0x1::string::String {
        0x1::string::utf8(b"Go Fordefi!")
    }

    public entry fun ping(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

