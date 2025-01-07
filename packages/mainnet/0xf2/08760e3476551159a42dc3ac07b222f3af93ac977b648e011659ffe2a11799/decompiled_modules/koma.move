module 0xf208760e3476551159a42dc3ac07b222f3af93ac977b648e011659ffe2a11799::koma {
    struct KOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMA>(arg0, 6, b"KOMA", b"KOMARI", b"WELCOME TO KOMARI ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5a12975bf0158c9c3b23622f44917d113f31842d_167dd07874.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

