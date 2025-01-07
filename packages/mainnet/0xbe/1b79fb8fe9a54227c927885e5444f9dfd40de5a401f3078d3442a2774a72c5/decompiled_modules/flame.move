module 0xbe1b79fb8fe9a54227c927885e5444f9dfd40de5a401f3078d3442a2774a72c5::flame {
    struct FLAME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLAME>, arg1: 0x2::coin::Coin<FLAME>) {
        0x2::coin::burn<FLAME>(arg0, arg1);
    }

    fun init(arg0: FLAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAME>(arg0, 6, b"FLAME", b"FLAME", b"official token utility of flameswap", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLAME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLAME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

