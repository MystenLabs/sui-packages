module 0xc3d5f2c20f03ee94eacdc73bb5eec068d34d4a12f9be84e605496a75c61a63e3::pinger {
    public fun get_greeting() : 0x1::string::String {
        0x1::string::utf8(b"Go Fordefi!")
    }

    public entry fun ping(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

