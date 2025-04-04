module 0xf90322e71c5f8bcd469abc29182badec2d9c52e8cfa9fb1a52ef77405a6b37ba::raki {
    struct RAKI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RAKI>, arg1: 0x2::coin::Coin<RAKI>) {
        0x2::coin::burn<RAKI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RAKI>>(0x2::coin::mint<RAKI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKI>(arg0, 9, b"raki", b"RAKI", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

