module 0x872a49d45e0f309d217b6f2665bfaae81d2e2172b05bad2a3b04f767d6d7b030::duckcoin {
    struct DUCKCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCKCOIN>, arg1: 0x2::coin::Coin<DUCKCOIN>) {
        0x2::coin::burn<DUCKCOIN>(arg0, arg1);
    }

    fun init(arg0: DUCKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKCOIN>(arg0, 9, b"DUCKCOIN", b"DUCK", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCKCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUCKCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

