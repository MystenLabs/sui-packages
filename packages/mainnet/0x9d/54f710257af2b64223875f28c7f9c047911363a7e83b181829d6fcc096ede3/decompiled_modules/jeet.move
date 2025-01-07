module 0x9d54f710257af2b64223875f28c7f9c047911363a7e83b181829d6fcc096ede3::jeet {
    struct JEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEET>(arg0, 6, b"JEET", b"Sui Jeet Jackal", b"The must-have Memecoin on Sui, Jeet captures the energetic, fast-paced world of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jet_cceb039a31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

