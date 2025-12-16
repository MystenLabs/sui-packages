module 0x833c8a5b7a2e02e7a35d30801d04d2330270496eae603c62e7a0b2ac0b9df613::b_tomcat {
    struct B_TOMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TOMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TOMCAT>(arg0, 9, b"bTOMCAT", b"bToken TOMCAT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TOMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TOMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

