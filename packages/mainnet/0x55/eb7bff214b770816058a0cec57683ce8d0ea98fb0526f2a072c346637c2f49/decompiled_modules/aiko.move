module 0x55eb7bff214b770816058a0cec57683ce8d0ea98fb0526f2a072c346637c2f49::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"AIKO", b"Agent AiKo", b"Your a crypto girl agent, AiKo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1291_d27fafbe2e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

