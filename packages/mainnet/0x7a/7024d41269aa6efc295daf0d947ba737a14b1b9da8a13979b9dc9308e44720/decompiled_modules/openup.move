module 0x7a7024d41269aa6efc295daf0d947ba737a14b1b9da8a13979b9dc9308e44720::openup {
    struct OPENUP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OPENUP>, arg1: 0x2::coin::Coin<OPENUP>) {
        0x2::coin::burn<OPENUP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPENUP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OPENUP>>(0x2::coin::mint<OPENUP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: OPENUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPENUP>(arg0, 9, b"OPENUP", b"OPENUP", b"TESTER", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPENUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPENUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

