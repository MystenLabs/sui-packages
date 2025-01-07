module 0xf5174ac387ae99b39065b808ca2e4a812132dbef1006bd87215622f6f95e7823::sgui {
    struct SGUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGUI>(arg0, 8, b"SGUI", b"Stupid games on SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b" https://m.media-amazon.com/images/I/61zJfLMrC0L._AC_UF894,1000_QL80_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SGUI>(&mut v2, 11111111100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

