module 0x53fa6077b4345c79281d0fd04487c5833d857d73b5705ee17fee6c55975b6b96::suishiba {
    struct SUISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIBA>(arg0, 9, b"Shiba Inu", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_me(arg0: &mut 0x2::coin::TreasuryCap<SUISHIBA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(0x2::coin::mint<SUISHIBA>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

