module 0x83f468cd555d840024ad1df9bc4f516b63ee6e4b57aa4c4fe38be5171d21829c::RIDE {
    struct RIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIDE>(arg0, 9, b"rider", b"RIDE", b"riderx", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<RIDE>>(0x2::coin::mint<RIDE>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIDE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIDE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

