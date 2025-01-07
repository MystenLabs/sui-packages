module 0xf2761e4dfb2bdcf4f422cce3f29dff78fef7251263f224d9cd6420fcaa46239::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: 0x2::coin::Coin<MANAGED>) {
        0x2::coin::burn<MANAGED>(arg0, arg1);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED>(arg0, 2, b"SUIHIGH", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MANAGED>(&mut v2, 100000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v2, v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

