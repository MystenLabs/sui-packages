module 0xe96a710862f95a591e42e160f8dd5b4a53c90b3242c34e754f0baa28f9edfcf1::mahiru {
    struct MAHIRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAHIRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAHIRU>(arg0, 6, b"MAHIRU", b"MAHIRUCOIN", b"Anime character named Mahiru Shiina is a woman who does not exist in the real world, this coin supports AI and text to speech projects", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735185312624.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAHIRU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAHIRU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

