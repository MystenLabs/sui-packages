module 0xe06d4557a33f5269dcc24bec470c7de2d1865810d6a5f47f5fe09d817c375d96::rogue_sui {
    struct ROGUE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGUE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGUE_SUI>(arg0, 9, b"rogueSUI", b"Rogue Sui", b"A liquid staking token by Liquid Agents liq.ag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7wiiytcj6qhel34ssbvccgbetq0oprjr.lambda-url.us-west-2.on.aws/?file=2025-04-27T09-32-08-693Z-518700be5d0d66af")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROGUE_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGUE_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

