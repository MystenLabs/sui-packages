module 0x8355146bdb3e75d60461fdce0c879fc720cd64952d1d058e303fb233c8452db2::penis {
    struct PENIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENIS>(arg0, 6, b"PENIS", b"penis", b"aapenis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://hop.fun/")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<PENIS>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<PENIS>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

