module 0x7e292fbe2acdebfbc8e72c6e3bc93b6ac2af652cb7769b59411b3c541b86ed8d::suipad {
    struct SUIPAD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPAD>, arg1: 0x2::coin::Coin<SUIPAD>) {
        0x2::coin::burn<SUIPAD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPAD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPAD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAD>(arg0, 0, b"suipad", b"SUIPAD", b"Releap Profile Token: suipad", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<SUIPAD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIPAD> {
        0x2::coin::mint<SUIPAD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

