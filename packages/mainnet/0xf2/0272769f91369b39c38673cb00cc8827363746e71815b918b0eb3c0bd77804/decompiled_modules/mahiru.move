module 0xf20272769f91369b39c38673cb00cc8827363746e71815b918b0eb3c0bd77804::mahiru {
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

