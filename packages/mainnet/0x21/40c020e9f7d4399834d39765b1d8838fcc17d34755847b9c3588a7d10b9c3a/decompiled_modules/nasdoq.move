module 0x2140c020e9f7d4399834d39765b1d8838fcc17d34755847b9c3588a7d10b9c3a::nasdoq {
    struct NASDOQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NASDOQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NASDOQ>(arg0, 6, b"NASDOQ", b"Nasdaq dog", b"the dog wif stocks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091267_adeb2c0c95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NASDOQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NASDOQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

