module 0x195e92c82803d944b97e3aeb09845a953464c021726f64dc08437a11eb6bac8a::ada_sui {
    struct ADA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA_SUI>(arg0, 9, b"adaSUI", b"Cardano Staked SUI", b"Cardano Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/4e013e25-f00d-436d-b2b8-9098b335fd9e/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADA_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

