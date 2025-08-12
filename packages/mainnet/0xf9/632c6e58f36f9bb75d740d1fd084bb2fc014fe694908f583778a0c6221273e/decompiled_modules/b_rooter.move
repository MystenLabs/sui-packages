module 0xf9632c6e58f36f9bb75d740d1fd084bb2fc014fe694908f583778a0c6221273e::b_rooter {
    struct B_ROOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ROOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ROOTER>(arg0, 9, b"bROOTER", b"bToken ROOTER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ROOTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ROOTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

