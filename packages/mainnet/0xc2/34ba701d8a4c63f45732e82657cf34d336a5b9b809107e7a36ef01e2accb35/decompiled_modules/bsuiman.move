module 0xc234ba701d8a4c63f45732e82657cf34d336a5b9b809107e7a36ef01e2accb35::bsuiman {
    struct BSUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIMAN>(arg0, 6, b"Bsuiman", b"Baby Suiman", b"Bsyuiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_19_31_28_8a7302207e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

