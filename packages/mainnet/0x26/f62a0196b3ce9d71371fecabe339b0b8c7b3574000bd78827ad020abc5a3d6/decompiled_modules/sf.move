module 0x26f62a0196b3ce9d71371fecabe339b0b8c7b3574000bd78827ad020abc5a3d6::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SF>(arg0, 6, b"SF", b"SatriaFU by SuiAI", b"Speed game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/qr_ID_1024325914918_10_08_24_172329656_658f6d3369.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

