module 0x998c5341903e74de648b8a728a8ec6631b612166cec384b4d28af57a8e7b364a::hypx {
    struct HYPX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HYPX>, arg1: 0x2::coin::Coin<HYPX>) {
        0x2::coin::burn<HYPX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HYPX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HYPX>>(0x2::coin::mint<HYPX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HYPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPX>(arg0, 9, b"hypx", b"HYPX", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

