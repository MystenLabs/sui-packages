module 0x395f4bdcf403714a8c1582fd1b1d6b25944b92bbd97efc785b4809b0798caccc::b_tesdt {
    struct B_TESDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TESDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TESDT>(arg0, 9, b"bTESDT", b"bToken TESDT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TESDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TESDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

