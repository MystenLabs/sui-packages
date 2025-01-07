module 0xde7cf52145519c2db94eb402570dc2ec2c0d55a429882154a4d56ad9f75f3449::catwizai {
    struct CATWIZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATWIZAI>(arg0, 6, b"CATWIZAI", b"CatWizardAi", b"Ai agent for finding social alpha ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000085728_667c92070a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATWIZAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIZAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

