module 0xbc176ed70a8e453d9a19dfaf14b41cb8f9e3369fcea1d33874a25dd03a383d97::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINI>, arg1: 0x2::coin::Coin<MINI>) {
        0x2::coin::burn<MINI>(arg0, arg1);
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 6, b"MINI", b"MINI Test", b"Coin test by dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://docs.sui.io/img/sui-logo-dark.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINI>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINI>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINI>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MINI>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

