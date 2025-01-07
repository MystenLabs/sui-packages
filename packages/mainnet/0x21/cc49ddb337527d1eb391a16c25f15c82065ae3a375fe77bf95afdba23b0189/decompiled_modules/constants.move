module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants {
    public fun bps() : u64 {
        10000
    }

    public fun default_config_key() : 0x1::ascii::String {
        0x1::ascii::string(b"DEFAULT")
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

