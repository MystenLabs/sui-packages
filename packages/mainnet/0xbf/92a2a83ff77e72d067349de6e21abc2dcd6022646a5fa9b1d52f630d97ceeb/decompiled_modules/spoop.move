module 0xbf92a2a83ff77e72d067349de6e21abc2dcd6022646a5fa9b1d52f630d97ceeb::spoop {
    struct SPOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOP>(arg0, 6, b"SPOOP", b"SUIPOOP", b"SUI POOOP STOP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_b911b25663.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

