module 0xfaf72cc3788789ea945e1d8afecce0a28083ba8c34ec86eeb11d0ad2c658fe6d::SUI_TEST {
    struct SUI_TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_TEST>, arg1: 0x2::coin::Coin<SUI_TEST>) {
        0x2::coin::burn<SUI_TEST>(arg0, arg1);
    }

    fun init(arg0: SUI_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_TEST>(arg0, 2, b"SUI_TEST", b"TEST", b"SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_TEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

