module 0xe6ee5f431f130781be70517b17533224c68a5f4f4424614fdd81099ff978375f::tryx {
    struct TRYX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRYX>, arg1: 0x2::coin::Coin<TRYX>) {
        0x2::coin::burn<TRYX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRYX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRYX>>(0x2::coin::mint<TRYX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TRYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYX>(arg0, 9, b"Tryx", b"TRYX", b"last try to do this", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRYX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

