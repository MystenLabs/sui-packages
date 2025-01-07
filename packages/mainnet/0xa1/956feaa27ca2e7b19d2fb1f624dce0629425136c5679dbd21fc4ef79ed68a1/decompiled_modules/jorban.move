module 0xa1956feaa27ca2e7b19d2fb1f624dce0629425136c5679dbd21fc4ef79ed68a1::jorban {
    struct JORBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORBAN>(arg0, 6, b"Jorban", b"Jorban Shoes", b"real jorban shoes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731998477279.gallery")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JORBAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORBAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

