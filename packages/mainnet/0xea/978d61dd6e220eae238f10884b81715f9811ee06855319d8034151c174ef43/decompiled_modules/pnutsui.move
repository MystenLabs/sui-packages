module 0xea978d61dd6e220eae238f10884b81715f9811ee06855319d8034151c174ef43::pnutsui {
    struct PNUTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTSUI>(arg0, 9, b"Pnutsui", b"Pnut Squirrel", b"Paying humage to Pnut. R.I.P", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/v2mYjqY7ZivXfXEj9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PNUTSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

