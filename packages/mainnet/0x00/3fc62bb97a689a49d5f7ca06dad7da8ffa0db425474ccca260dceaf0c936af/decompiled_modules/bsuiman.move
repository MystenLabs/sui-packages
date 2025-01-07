module 0x3fc62bb97a689a49d5f7ca06dad7da8ffa0db425474ccca260dceaf0c936af::bsuiman {
    struct BSUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIMAN>(arg0, 6, b"BSUIMAN", b"Baby Suiman", b"Baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_19_37_38_ad5b7b8de3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

