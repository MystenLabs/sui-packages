module 0x3db438fda6d5200d5242da78db5b9081ca48fa5ef5ccabba8fcb4732746e3f7d::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: 0x2::coin::Coin<MY_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MY_TOKEN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_TOKEN>>(0x2::coin::mint<MY_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 9, b"MYT", b"My Token", b"A custom token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

