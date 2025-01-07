module 0xc5639a8cbd6124973dd12927a314dffd502b1b356d9bbb8fccddc7cb98cc5434::sky3 {
    struct SKY3 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SKY3>, arg1: 0x2::coin::Coin<SKY3>) {
        0x2::coin::burn<SKY3>(arg0, arg1);
    }

    fun init(arg0: SKY3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY3>(arg0, 9, b"SKY3", b"SKY3", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKY3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY3>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SKY3>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SKY3>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

