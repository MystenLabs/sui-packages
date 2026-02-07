module 0xdf6fb812b9da547b5fb6eca5ccd564c8a57ba813beb786d480158390c55aae6f::oracle_mock {
    public fun convert_sui_to_buck(arg0: u64) : u64 {
        arg0 * 1500 / 1000
    }

    public fun get_sui_price_buck() : u64 {
        1500
    }

    // decompiled from Move bytecode v6
}

