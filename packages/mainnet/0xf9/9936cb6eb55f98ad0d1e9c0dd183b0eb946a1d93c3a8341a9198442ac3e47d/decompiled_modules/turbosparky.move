module 0xf99936cb6eb55f98ad0d1e9c0dd183b0eb946a1d93c3a8341a9198442ac3e47d::turbosparky {
    struct TURBOSPARKY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TURBOSPARKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TURBOSPARKY>>(0x2::coin::mint<TURBOSPARKY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TURBOSPARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSPARKY>(arg0, 6, b"TURBO SPARKY DOG", b"TurboSparky", b"TURBO SPARKY DOG MEME COIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSPARKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSPARKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

