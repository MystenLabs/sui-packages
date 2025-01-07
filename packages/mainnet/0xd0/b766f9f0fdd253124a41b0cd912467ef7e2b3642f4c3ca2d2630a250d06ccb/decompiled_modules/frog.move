module 0xd0b766f9f0fdd253124a41b0cd912467ef7e2b3642f4c3ca2d2630a250d06ccb::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"hopfrog", b"frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.livescience.com%2F50692-frog-facts.html&psig=AOvVaw1NMV2tMTCXS-lLroV79C29&ust=1729543626195000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKDhxJ7qnYkDFQAAAAAdAAAAABAE")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<FROG>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<FROG>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

