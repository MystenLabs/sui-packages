module 0x659a826578790ccfe9b13e405283c72e941012c4dfb6b516f07d70405bb30952::VICENT {
    struct VICENT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<VICENT>, arg1: 0x2::coin::Coin<VICENT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<VICENT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VICENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VICENT>>(0x2::coin::mint<VICENT>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<VICENT>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VICENT>>(arg0);
    }

    fun init(arg0: VICENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VICENT>(arg0, 9, b"VICENT", b"VICENTINO", b"VICENT COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/61xa1mU0OYL._AC_UF1000,1000_QL80_.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

