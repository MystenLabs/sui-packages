module 0x18fc53e22b54668153171e4d093de55b9e3eb85f587780c687b16ee39ce016d0::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MEGA>(arg0, 156111814972353650, b"MEGABYTE", b"MEGA", x"2d20556e69636f726e7321202053706964657273212020416e74732120646f206e6f7420245375692452656e646572200a244d45474142595445202d20226f6620616c6c20427954655322", b"https://images.hop.ag/ipfs/QmYPFggZdfRCicbfMykPggHTLaqH1Q9pzHeBkZ1Uca6WCE", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

