module 0x9170b2b94eca47dfc950971ba76ad9b7cde540e4e8034bb4fafbd7beab4ae151::xan {
    struct XAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAN>(arg0, 9, b"XAN", b"XAN", b"XAN Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XAN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

