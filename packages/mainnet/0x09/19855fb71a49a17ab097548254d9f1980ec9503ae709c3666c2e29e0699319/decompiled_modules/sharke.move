module 0x919855fb71a49a17ab097548254d9f1980ec9503ae709c3666c2e29e0699319::sharke {
    struct SHARKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKE>(arg0, 6, b"SHARKE", b"Sharke", b"SHARKE IS A, JEETNIVOROUS, BIG FISH WITH A DEEP STOMACH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000833742.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

