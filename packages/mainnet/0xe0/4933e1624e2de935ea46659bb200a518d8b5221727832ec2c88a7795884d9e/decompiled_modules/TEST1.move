module 0xe04933e1624e2de935ea46659bb200a518d8b5221727832ec2c88a7795884d9e::TEST1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST1>, arg1: 0x2::coin::Coin<TEST1>) {
        0x2::coin::burn<TEST1>(arg0, arg1);
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 2, b"test1", b"test1", b"test1", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

