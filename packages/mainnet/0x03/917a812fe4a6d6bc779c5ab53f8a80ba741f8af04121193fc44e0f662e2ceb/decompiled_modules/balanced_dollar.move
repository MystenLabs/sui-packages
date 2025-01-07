module 0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar {
    struct BALANCED_DOLLAR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BALANCED_DOLLAR>, arg1: 0x2::coin::Coin<BALANCED_DOLLAR>) {
        0x2::coin::burn<BALANCED_DOLLAR>(arg0, arg1);
    }

    fun init(arg0: BALANCED_DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALANCED_DOLLAR>(arg0, 9, b"bnUSD", b"Balanced Dollar", b"A stable coin issued by Balanced", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/balancednetwork/assets/master/blockchains/icon/assets/cx88fd7df7ddff82f7cc735c871dc519838cb235bb/logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALANCED_DOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALANCED_DOLLAR>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BALANCED_DOLLAR>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BALANCED_DOLLAR>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

