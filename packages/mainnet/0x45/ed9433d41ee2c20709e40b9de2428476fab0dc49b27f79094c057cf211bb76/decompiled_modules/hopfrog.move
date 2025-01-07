module 0x45ed9433d41ee2c20709e40b9de2428476fab0dc49b27f79094c057cf211bb76::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 796740918626031773, b"Hop The Frog", b"HOPFROG", x"46726f6d207468652061736865732c2061206e657720636f6d6d756e69747920726f73653a206e6f74206a75737420612046726f672c206275742061206d6f72652067726f756e6465642c20756e69746564205368696e6f626920446f6a6f202d20e382abe382a8e383abe38292e382b8e383a3e383b3e38397e38195e3819be381a62e", b"https://images.hop.ag/ipfs/QmW1wbzTvm8WpihKphkGtJXKNiY5KgxQkYtW6ociGQLztp", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

