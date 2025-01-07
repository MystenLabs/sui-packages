module 0xb489517a83c5f000b99c9a48a169cb03b1ad48d78fa289eca247c238e1af17c4::mazz {
    struct MAZZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAZZ>, arg1: 0x2::coin::Coin<MAZZ>) {
        0x2::coin::burn<MAZZ>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAZZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAZZ>>(0x2::coin::mint<MAZZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MAZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZZ>(arg0, 9, b"mazz", b"MAZZ", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAZZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAZZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

