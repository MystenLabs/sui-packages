module 0xab0da7aa50f3ecef6f01739b300d029ee9a6cc1002ae9f6fa9e57d748cf59dd3::jape {
    struct JAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAPE>(arg0, 6, b"JAPE", b"JUST APE", b"Just ape. 1 million soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_211326_892_336956143a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

