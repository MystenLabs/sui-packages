module 0x263fd1101dd8b07e618aadc7dc2fefcf66dcb86e50c3684a34e2e1637fd9671f::gondola {
    struct GONDOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONDOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONDOLA>(arg0, 6, b"GONDOLA", b"Gondola Sui", x"4a6f696e206e6f773a2068747470733a2f2f676f6e646f6c616f6e7375692e78797a0a68747470733a2f2f782e636f6d2f476f6e646f6c615f5375690a68747470733a2f2f742e6d652f476f6e646f6c615f537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gondola_3_d7ce5478cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONDOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONDOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

