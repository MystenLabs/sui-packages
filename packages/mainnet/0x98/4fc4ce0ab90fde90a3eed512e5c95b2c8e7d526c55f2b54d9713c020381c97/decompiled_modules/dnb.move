module 0x984fc4ce0ab90fde90a3eed512e5c95b2c8e7d526c55f2b54d9713c020381c97::dnb {
    struct DNB has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DNB>, arg1: 0x2::coin::Coin<DNB>) {
        0x2::coin::burn<DNB>(arg0, arg1);
    }

    fun init(arg0: DNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNB>(arg0, 2, b"DNB", b"DNB", b"DO NOT BUY", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DNB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DNB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

