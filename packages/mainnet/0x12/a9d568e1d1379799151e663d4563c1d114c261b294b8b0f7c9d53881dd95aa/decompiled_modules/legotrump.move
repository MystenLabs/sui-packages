module 0x12a9d568e1d1379799151e663d4563c1d114c261b294b8b0f7c9d53881dd95aa::legotrump {
    struct LEGOTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOTRUMP>(arg0, 6, b"LEGOTRUMP", b"Lego Trump", b"Meet the LEGOTRUMP, The only coin where Trump builds his own wall, one brick at a time. No instructions needed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1d2160f11e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

