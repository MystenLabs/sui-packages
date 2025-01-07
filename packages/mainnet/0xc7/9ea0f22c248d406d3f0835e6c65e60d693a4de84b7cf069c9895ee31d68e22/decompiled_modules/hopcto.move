module 0xc79ea0f22c248d406d3f0835e6c65e60d693a4de84b7cf069c9895ee31d68e22::hopcto {
    struct HOPCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCTO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPCTO>(arg0, 2997138391706434331, b"HOP CTO", b"HOPCTO", x"4c6f736520796f75722074696d652049524c2026206f6e200a405375694e6574776f726b", b"https://images.hop.ag/ipfs/QmdeKP6WQJVZ5Ct9EF1p2xteTec1QZA3fFXksrEvbPqFTH", 0x1::string::utf8(b"https://x.com/HopCto"), 0x1::string::utf8(b"https://hopcto.fun"), 0x1::string::utf8(b"https://t.me/HOPFUNCTO"), arg1);
    }

    // decompiled from Move bytecode v6
}

