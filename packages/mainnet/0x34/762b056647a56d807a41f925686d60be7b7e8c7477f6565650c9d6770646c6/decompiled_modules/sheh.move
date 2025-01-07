module 0x34762b056647a56d807a41f925686d60be7b7e8c7477f6565650c9d6770646c6::sheh {
    struct SHEH has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHEH>, arg1: 0x2::coin::Coin<SHEH>) {
        0x2::coin::burn<SHEH>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHEH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEH>>(0x2::coin::mint<SHEH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEH>(arg0, 9, b"Sheh", b"SHEH", b"Test Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

