module 0x419f9ed2f6610d310bc361659c62ca069490e225140fc3ff29eabf1ca1d66af6::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"SUI's DOg", b"dssd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/9dAOHoISzXM/hqdefault.jpg?sqp=-oaymwEmCOADEOgC8quKqQMa8AEB-AHeAoAChgKKAgwIABABGHIgVygvMA8=&rs=AOn4CLAYTx5JNYAtMzMT8qoGdHGgJckZ_w")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<DOG>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<DOG>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

