module 0x7bf8b3f969a6964569a3664c8d82c7495203272a81d5ec7c7ea62d2a3d001af8::ydamw {
    struct YDAMW has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YDAMW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YDAMW>>(0x2::coin::mint<YDAMW>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YDAMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YDAMW>(arg0, 6, b"YDAMW", b"ydamw", b"test coin for ydamw", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YDAMW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YDAMW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

