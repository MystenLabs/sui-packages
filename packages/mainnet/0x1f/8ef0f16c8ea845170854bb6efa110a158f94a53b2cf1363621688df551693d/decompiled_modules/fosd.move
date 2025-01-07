module 0x1f8ef0f16c8ea845170854bb6efa110a158f94a53b2cf1363621688df551693d::fosd {
    struct FOSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOSD>(arg0, 6, b"FOSD", b"FISO", b"FASF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Arm_959b56cdcb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

