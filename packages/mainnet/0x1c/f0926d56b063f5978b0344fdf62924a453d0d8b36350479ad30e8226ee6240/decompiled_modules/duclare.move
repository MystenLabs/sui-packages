module 0x1cf0926d56b063f5978b0344fdf62924a453d0d8b36350479ad30e8226ee6240::duclare {
    struct DUCLARE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCLARE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCLARE>>(0x2::coin::mint<DUCLARE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DUCLARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCLARE>(arg0, 6, b"DUCLARE", b"DUCLARE", b"This is the best christmas gift ever", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCLARE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCLARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

