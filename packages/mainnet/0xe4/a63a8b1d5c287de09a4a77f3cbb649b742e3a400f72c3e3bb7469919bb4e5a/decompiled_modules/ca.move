module 0xe4a63a8b1d5c287de09a4a77f3cbb649b742e3a400f72c3e3bb7469919bb4e5a::ca {
    struct CA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CA>, arg1: 0x2::coin::Coin<CA>) {
        0x2::coin::burn<CA>(arg0, arg1);
    }

    fun init(arg0: CA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CA>(arg0, 2, b"COIN A", b"CA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

