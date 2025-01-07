module 0xf9e4dbfb0efef37d79116dc8065e1989f98f71e66d86d76eaf0f8652caf5ff21::hoppie {
    struct HOPPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPIE>(arg0, 6, b"HOPPIE", b"Hoppie", x"546865204f47204d6173636f74206f6620486f702e66756e20f09f9087", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GaW2aH6WAAAc_TZ?format=jpg&name=large")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HOPPIE>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HOPPIE>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

