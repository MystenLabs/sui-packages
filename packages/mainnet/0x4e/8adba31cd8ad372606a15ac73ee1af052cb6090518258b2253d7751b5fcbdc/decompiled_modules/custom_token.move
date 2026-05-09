module 0x4e8adba31cd8ad372606a15ac73ee1af052cb6090518258b2253d7751b5fcbdc::custom_token {
    struct CUSTOM_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CUSTOM_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CUSTOM_TOKEN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CUSTOM_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CUSTOM_TOKEN>(arg0, 9, b"698da8e3", b"9ef2a268", b"1c26d810", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<CUSTOM_TOKEN>>(0x2::coin::mint<CUSTOM_TOKEN>(&mut v3, 1000000000000000, arg1), v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSTOM_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSTOM_TOKEN>>(v3, v0);
    }

    // decompiled from Move bytecode v7
}

