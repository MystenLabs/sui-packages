module 0xb06a62fd97f1e6d2469cce79856486523f8d07aba70baa1bd546dfad7973b1a1::shock {
    struct SHOCK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHOCK>, arg1: 0x2::coin::Coin<SHOCK>) {
        0x2::coin::burn<SHOCK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHOCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHOCK>>(0x2::coin::mint<SHOCK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCK>(arg0, 9, b"SHOCK", b"AfterShock Token", b"Governance token for AfterShock platform", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOCK>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHOCK>>(v0);
    }

    // decompiled from Move bytecode v6
}

