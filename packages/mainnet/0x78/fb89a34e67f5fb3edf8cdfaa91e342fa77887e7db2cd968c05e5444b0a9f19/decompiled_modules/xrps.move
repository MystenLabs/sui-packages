module 0x78fb89a34e67f5fb3edf8cdfaa91e342fa77887e7db2cd968c05e5444b0a9f19::xrps {
    struct XRPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRPS>(arg0, 6, b"XRPS", b"XRPonSUI", x"47657420726561647921205265616c202458525020697320636f6d696e6720746f205355492c20616e6420697427732061626f757420746f207265766f6c7574696f6e697a6520746865206e6574776f726b210a4a6f696e207468652024585250205355492061726d7920616e64206c6574277320726561636820666f722074686520737461727320746f6765746865722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xrp_c41dbfcdaa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

