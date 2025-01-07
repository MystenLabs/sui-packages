module 0x66e64713f06fd87bb1dfa16f42f5a27b2671ed29f3c42eb6c565f76810be2d9c::popdolphin {
    struct POPDOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOLPHIN>(arg0, 6, b"POPDOLPHIN", b"POP DOLPHIN", b"pop dolphin launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_drawn_cartoon_dolphin_illustration_23_2150590965_3e3f5e75f4.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

