module 0xded7aedf23d1a1dabb647713c065b4efd6a785cd292b5a46d5e61230951e549c::Wonder {
    struct WONDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONDER>(arg0, 9, b"WONDER", b"Wonder", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1867707152384557056/OC193jSQ_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

