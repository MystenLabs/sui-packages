module 0x5d407722c076bd8cd60a516b733f8e45e2d7bf9a70283805d18b3328212c1148::t_123 {
    struct T_123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T_123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T_123>(arg0, 6, b"T123", b"testing coin 123", b"this is a testing coin only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hop.ag/tokens/FUD.webp")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<T_123>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<T_123>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

