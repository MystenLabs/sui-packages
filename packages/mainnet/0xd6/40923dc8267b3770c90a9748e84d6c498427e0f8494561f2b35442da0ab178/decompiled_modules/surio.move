module 0xd640923dc8267b3770c90a9748e84d6c498427e0f8494561f2b35442da0ab178::surio {
    struct SURIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURIO>(arg0, 6, b"SURIO", b"Sui Mario", b"Join $SURIO as he hops through pipes and jumps over obstacles in the Sui Network. Always on a quest to reach the next level, hes here to bring some platformer style fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_e611c5cfa9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

