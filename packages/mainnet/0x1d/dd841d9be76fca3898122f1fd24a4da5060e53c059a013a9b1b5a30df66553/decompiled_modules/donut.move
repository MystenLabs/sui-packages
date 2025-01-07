module 0x1ddd841d9be76fca3898122f1fd24a4da5060e53c059a013a9b1b5a30df66553::donut {
    struct DONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONUT>(arg0, 6, b"DONUT", b"DogeNuttoken", x"0a68747470733a2f2f646f67656e75742e6c6f6c0a0a68747470733a2f2f742e6d652f5355495f444f47454e55540a0a68747470733a2f2f782e636f6d2f5355495f444f47454e55540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dogenut_414c57a121.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

