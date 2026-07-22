module 0x767f31c7c864e6cfe2337d4329836293392c00a50dd0e98e2547c80769b22124::fake_sui {
    struct FAKE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_SUI>(arg0, 9, b"SUI", b"Sui", b"Sui native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/sui_c07df05f00.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

