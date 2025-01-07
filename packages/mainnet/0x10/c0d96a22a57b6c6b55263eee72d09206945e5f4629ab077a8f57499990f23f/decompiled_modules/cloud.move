module 0x10c0d96a22a57b6c6b55263eee72d09206945e5f4629ab077a8f57499990f23f::cloud {
    struct CLOUD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLOUD>, arg1: 0x2::coin::Coin<CLOUD>) {
        0x2::coin::burn<CLOUD>(arg0, arg1);
    }

    fun init(arg0: CLOUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUD>(arg0, 4, b"CLOUD", b"CLOUD", b"SUI CLOUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/T38Q2VC68NJhTiD2f1gHJDj5M5RiXayctBFZCsHSaE4.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0x2dcf4cf33e8db8c553c5f1fb0fd68d81222927652d31cf604675e5322bb1407e, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUD>>(v2, @0x2dcf4cf33e8db8c553c5f1fb0fd68d81222927652d31cf604675e5322bb1407e);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLOUD>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLOUD>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

