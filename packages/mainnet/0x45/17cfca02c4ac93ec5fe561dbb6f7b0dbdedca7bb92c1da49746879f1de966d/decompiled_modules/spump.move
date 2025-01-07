module 0x4517cfca02c4ac93ec5fe561dbb6f7b0dbdedca7bb92c1da49746879f1de966d::spump {
    struct SPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUMP>(arg0, 6, b"SPUMP", b"SUI PUMP", b"SUI PUMP is the token that rises straight from the abyss, ready to surface and propel the sui ecosystem to uncharted heights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/SUI_PUMP_84716d3883.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

