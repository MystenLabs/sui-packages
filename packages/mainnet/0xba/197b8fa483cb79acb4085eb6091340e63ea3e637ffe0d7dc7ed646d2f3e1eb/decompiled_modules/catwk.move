module 0xba197b8fa483cb79acb4085eb6091340e63ea3e637ffe0d7dc7ed646d2f3e1eb::catwk {
    struct CATWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWK>(arg0, 9, b"Cat With Knife", b"CATWK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/IoRIE55.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWK>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATWK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

