module 0xc46e1205d96d550f59361bc1e531ef4ac0f25f809bc1cb4e4bc3e6a13bb33c5f::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"SUI's Dog", b"First Dog deployed on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/9dAOHoISzXM/hqdefault.jpg?sqp=-oaymwEmCOADEOgC8quKqQMa8AEB-AHeAoAChgKKAgwIABABGHIgVygvMA8=&rs=AOn4CLAYTx5JNYAtMzMT8qoGdHGgJckZ_w")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<SUI>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<SUI>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

