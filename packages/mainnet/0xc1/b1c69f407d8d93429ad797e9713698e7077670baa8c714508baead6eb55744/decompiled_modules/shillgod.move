module 0xc1b1c69f407d8d93429ad797e9713698e7077670baa8c714508baead6eb55744::shillgod {
    struct SHILLGOD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHILLGOD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHILLGOD>>(0x2::coin::mint<SHILLGOD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHILLGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHILLGOD>(arg0, 6, b"SHILLGOD", b"SHILLGOD", b"This is SHILLGOD token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHILLGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHILLGOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

