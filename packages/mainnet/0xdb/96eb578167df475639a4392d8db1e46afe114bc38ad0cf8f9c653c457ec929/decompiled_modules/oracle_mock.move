module 0xdb96eb578167df475639a4392d8db1e46afe114bc38ad0cf8f9c653c457ec929::oracle_mock {
    public fun convert_sui_to_buck(arg0: u64) : u64 {
        arg0 * 1500 / 1000
    }

    public fun get_sui_price_buck() : u64 {
        1500
    }

    // decompiled from Move bytecode v6
}

