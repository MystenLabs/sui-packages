module 0xdd814a63f974bc3363fd35c7bdf02791bb22664eda96c6f81067362e0242f51f::arock {
    struct AROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AROCK>(arg0, 6, b"aRock", b"aaaRock", b"Simply a Rock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003819_b12f10933e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

