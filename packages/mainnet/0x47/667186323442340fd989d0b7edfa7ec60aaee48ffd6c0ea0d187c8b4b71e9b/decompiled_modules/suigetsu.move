module 0x47667186323442340fd989d0b7edfa7ec60aaee48ffd6c0ea0d187c8b4b71e9b::suigetsu {
    struct SUIGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIGETSU>(arg0, 6, b"SUIGETSU", b"Suigetsu AI by SuiAI", b"In the depths of the Hidden Village in the Mysten Labs, where the air is thick with intrigue and danger, one name cuts through like a blade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hpds_RXE_0_400x400_b3dd45f9c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGETSU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGETSU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

