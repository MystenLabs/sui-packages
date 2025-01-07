module 0xae406983c4be05b6730b83bbeaa36937e7853d8dc8f2d895fb05f17c81c60f81::coban {
    struct COBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBAN>(arg0, 9, b"COBAN", b"COBAN", b"COBAN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COBAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

