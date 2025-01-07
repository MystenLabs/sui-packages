module 0xac4fb5bce2d0a40c8978d96a9c361ed4f849010e75e89b1c0d3f76551da335de::suikosky {
    struct SUIKOSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOSKY>(arg0, 6, b"SUIKOSKY", b"Suikosky On Sui", x"0a7375696b6f736b7920697320612077696c646c7920656363656e7472696320616e6420656e7465727461696e696e67206368617261637465722077697468696e2074686520737569206e6574776f726b2c2062657374206b6e6f776e20666f722068697320656e6f726d6f75732c206f76657273697a656420656767732074686174206865206c6f76657320746f20686f6c64206f6e746f207769746820677265617420656e746875736961736d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_201554_7d4e59e354.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

