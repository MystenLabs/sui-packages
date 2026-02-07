module 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::oracle_mock {
    public fun convert_sui_to_buck(arg0: u64) : u64 {
        arg0 * 1500 / 1000
    }

    public fun get_sui_price_buck() : u64 {
        1500
    }

    // decompiled from Move bytecode v6
}

