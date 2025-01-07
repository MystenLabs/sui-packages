module 0x4a523ff23e38761403484ba3d651095b056f42e1d89c87412eed31cdc2cbbace::suigull {
    struct SUIGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGULL>(arg0, 6, b"SUIGULL", b"SUIGULL_SUI", x"53756967756c6c2074686520636f6f6c657374206d656d65206f6620616c6c210a436865636b206f6666696369616c2077656273697465207777772e73756967756c6c2e78797a0a444f204e4f542046414c4c20464f52205343414d5320414c5741595320434845434b2054525545204341204f4e20574542534954450a0a4a4f494e20544720616e64206c65747320626f756e6420746f676574686572210a0a4465782077696c6c20626520757064617465642073686f72746c79206166746572206c61756e636821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IOCONA_DEX_SCREENER_e1556da46f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

