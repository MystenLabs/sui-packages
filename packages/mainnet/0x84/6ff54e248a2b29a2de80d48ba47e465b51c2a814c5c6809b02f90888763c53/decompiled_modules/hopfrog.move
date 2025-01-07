module 0x846ff54e248a2b29a2de80d48ba47e465b51c2a814c5c6809b02f90888763c53::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HOPFROG>(arg0, 2032355935318399773, b"Hop The Frog", b"HOPFROG", x"e382abe382a8e383abe38292e9a39be381b0e3819b202d202246726f6d207468652061736865732c2061206e657720636f6d6d756e69747920726f73653a206e6f74206a75737420612046726f672c206275742061206d6f72652067726f756e6465642c20756e69746564205368696e6f626920446f6a6f2e22", b"https://images.hop.ag/ipfs/QmeMhdbDbstChc2B3GYQWK4Koqdqdjs57rkAAyL5kKArzz", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

