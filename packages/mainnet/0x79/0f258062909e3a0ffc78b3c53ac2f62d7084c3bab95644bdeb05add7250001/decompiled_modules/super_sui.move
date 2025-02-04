module 0x790f258062909e3a0ffc78b3c53ac2f62d7084c3bab95644bdeb05add7250001::super_sui {
    struct SUPER_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER_SUI>(arg0, 9, b"superSUI", b"superSUI", b"Metastable Super Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/super-sui.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPER_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

