module 0xba4a87f2ad4e02512112a63acdcf3ecef174beb43c82cd06cfe1daf40e0edd60::KUDISUN {
    struct KUDISUN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KUDISUN>, arg1: 0x2::coin::Coin<KUDISUN>) {
        0x2::coin::burn<KUDISUN>(arg0, arg1);
    }

    fun init(arg0: KUDISUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUDISUN>(arg0, 9, b"KUDISUN", b"KUDISUN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUDISUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUDISUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KUDISUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KUDISUN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

