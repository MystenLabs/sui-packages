module 0x6a4da89530f29896e6a5c3cdd070db53a468d2a028f7071c29bbb1fcdf565b7e::bacat {
    struct BACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACAT>(arg0, 6, b"BACAT", b"BANANA CAT", x"42414e414e412043415420617665732074686520776f726c642e0a68747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d63487349306e37314a763826736f757263655f76655f706174683d4d6a4d344e5445", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_350f594f16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

