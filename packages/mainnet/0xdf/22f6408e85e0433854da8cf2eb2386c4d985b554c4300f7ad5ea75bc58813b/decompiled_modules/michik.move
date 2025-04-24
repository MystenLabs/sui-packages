module 0xdf22f6408e85e0433854da8cf2eb2386c4d985b554c4300f7ad5ea75bc58813b::michik {
    struct MICHIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHIK>(arg0, 6, b"MICHIK", b"Michikwai On sui", b"MICHIKWAI was born out of pure love, soft paws, and the heartwarming purrs of kittens who just want to spread joy in the crypto world. Were a community united by cats, good vibes, and the magic of building something full of love and fluff together. With MICHIKWAI, youre not just getting a token  youre adopting a mission: to spread wholesomeness, support furry friends, and create a cozy digital space where everyone can purr in peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061868_a0f912ddf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICHIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

