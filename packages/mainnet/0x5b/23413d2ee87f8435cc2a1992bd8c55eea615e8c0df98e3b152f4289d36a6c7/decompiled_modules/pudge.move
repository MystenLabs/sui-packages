module 0x5b23413d2ee87f8435cc2a1992bd8c55eea615e8c0df98e3b152f4289d36a6c7::pudge {
    struct PUDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGE>(arg0, 6, b"PUDGE", b"PUDGY DOGE", x"505544475920444f47450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image01f07d_7c4f3a6008.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

