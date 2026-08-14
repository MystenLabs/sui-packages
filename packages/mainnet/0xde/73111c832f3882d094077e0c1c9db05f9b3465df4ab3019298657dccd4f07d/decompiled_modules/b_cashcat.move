module 0xde73111c832f3882d094077e0c1c9db05f9b3465df4ab3019298657dccd4f07d::b_cashcat {
    struct B_CASHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CASHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CASHCAT>(arg0, 9, b"bCASHCAT", b"bToken CASHCAT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CASHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CASHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

