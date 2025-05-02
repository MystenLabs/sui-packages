module 0x91eaa58db358d20a868060a95c04fb571a32e7484a501e0bfb0095d56cb1edf::cetustester {
    struct CETUSTESTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CETUSTESTER>, arg1: 0x2::coin::Coin<CETUSTESTER>) {
        0x2::coin::burn<CETUSTESTER>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUSTESTER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUSTESTER>>(0x2::coin::mint<CETUSTESTER>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUSTESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSTESTER>(arg0, 9, b"CETUSTESTER", b"CETUSTESTER", b"Tester", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSTESTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSTESTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

