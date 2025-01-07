module 0xd4ce61db015c09854c782cb898eb2af8ee6ec2f54d3f8c154e40b469530c5315::coin_a {
    struct COIN_A has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN_A>, arg1: 0x2::coin::Coin<COIN_A>) {
        0x2::coin::burn<COIN_A>(arg0, arg1);
    }

    fun init(arg0: COIN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_A>(arg0, 3, b"COIN_A", b"CA", b"coin_A", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_A>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN_A>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

