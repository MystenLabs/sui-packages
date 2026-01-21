module 0x429e0448e488eb65b56b2045291104497d2980c5b23baeb2cdfb2752670339eb::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: 0x2::coin::Coin<MY_TOKEN>) {
        0x2::coin::burn<MY_TOKEN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_TOKEN>>(0x2::coin::mint<MY_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 6, b"MOFT", b"MyOFT", b"My Omnichain Fungible Token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

