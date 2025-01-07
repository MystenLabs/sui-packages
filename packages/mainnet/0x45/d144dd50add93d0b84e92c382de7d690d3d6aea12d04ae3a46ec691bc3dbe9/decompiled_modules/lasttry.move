module 0x45d144dd50add93d0b84e92c382de7d690d3d6aea12d04ae3a46ec691bc3dbe9::lasttry {
    struct LASTTRY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LASTTRY>, arg1: 0x2::coin::Coin<LASTTRY>) {
        0x2::coin::burn<LASTTRY>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LASTTRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LASTTRY>>(0x2::coin::mint<LASTTRY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LASTTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASTTRY>(arg0, 9, b"Lasttry", b"LASTTRY", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LASTTRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASTTRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

