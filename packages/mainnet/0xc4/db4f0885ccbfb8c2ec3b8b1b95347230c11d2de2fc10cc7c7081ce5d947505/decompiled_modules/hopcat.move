module 0xc4db4f0885ccbfb8c2ec3b8b1b95347230c11d2de2fc10cc7c7081ce5d947505::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"HOP CAT", b"NEW HOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fnreach.io%2Fweb3-database-companies%2Fhop-aggregator%2F&psig=AOvVaw3neR5N-vbAFjVKaZNwQ-T-&ust=1729542701057000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPC6peTmnYkDFQAAAAAdAAAAABAE")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HOPCAT>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HOPCAT>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

