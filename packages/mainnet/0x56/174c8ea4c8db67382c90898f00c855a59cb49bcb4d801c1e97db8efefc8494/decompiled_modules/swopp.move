module 0x56174c8ea4c8db67382c90898f00c855a59cb49bcb4d801c1e97db8efefc8494::swopp {
    struct SWOPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOPP>(arg0, 6, b"SWOPP", b"HopSwoop", x"f09f90a4f09f92a720576f6f7020576f6f7020576f6f7020f09f92a7f09f90a4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845437720392343554/m_DxEB3I_400x400.jpg")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<SWOPP>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<SWOPP>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

