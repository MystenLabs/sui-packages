module 0xdaf65e28dc8b638524553e256b119f8be292d2a4c111e6ec963dd3919a6abc0e::tbase {
    struct TMOVE has drop {
        dummy_field: bool,
    }

    struct Cast has drop, store {
        user: address,
    }

    public fun tbase() {
        let v0 = 0x1::string::utf8(b"start tbase   ... ");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public fun tpai() : u64 {
        31415926
    }

    // decompiled from Move bytecode v6
}

