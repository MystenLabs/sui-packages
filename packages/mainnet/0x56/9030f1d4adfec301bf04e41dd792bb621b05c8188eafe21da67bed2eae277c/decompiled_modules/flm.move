module 0x569030f1d4adfec301bf04e41dd792bb621b05c8188eafe21da67bed2eae277c::flm {
    struct FLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLM>(arg0, 6, b"FLM", b"Flame Cat AI Agent", b"Flame Cat AI Agent MODEL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e4f3adc6_9ba0_49ed_bf33_c43368e19f44_4ed8973f1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

