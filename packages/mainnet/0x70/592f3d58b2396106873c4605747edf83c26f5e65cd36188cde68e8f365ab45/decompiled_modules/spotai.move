module 0x70592f3d58b2396106873c4605747edf83c26f5e65cd36188cde68e8f365ab45::spotai {
    struct SPOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOTAI>(arg0, 6, b"SPOTAI", b"SPOT AI NETWORK", b"Welcome to the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5859_5589e3f789.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

