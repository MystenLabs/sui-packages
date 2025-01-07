module 0x5621967f90105efcf765fdc83a6a506e97f65fc184ae22980299aced0052bc58::pogai {
    struct POGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGAI>(arg0, 9, b"POGAI", b"SuiPOGAI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POGAI>(&mut v2, 100000000000000000, @0x7ff43dd44b130408ff71c777b1bd1315bd9f55e88cb98ad8a6b82b5648b94c51, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POGAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

