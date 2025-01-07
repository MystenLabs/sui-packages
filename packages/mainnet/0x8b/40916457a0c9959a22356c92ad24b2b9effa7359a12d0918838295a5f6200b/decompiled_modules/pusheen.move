module 0x8b40916457a0c9959a22356c92ad24b2b9effa7359a12d0918838295a5f6200b::pusheen {
    struct PUSHEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSHEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSHEEN>(arg0, 6, b"PUSHEEN", b"Pusheen Cat", b"A blue cat who loves playing, laying down, eating and just being freakin' adorable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_18_19_22_01_0188f2151e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSHEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSHEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

