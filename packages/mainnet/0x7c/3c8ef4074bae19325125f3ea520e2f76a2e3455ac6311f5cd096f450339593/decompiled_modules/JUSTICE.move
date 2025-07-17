module 0x7c3c8ef4074bae19325125f3ea520e2f76a2e3455ac6311f5cd096f450339593::JUSTICE {
    struct JUSTICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTICE>(arg0, 6, b"HyphyOrange", b"JUSTICE", b"When I aura farm i do it like", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

