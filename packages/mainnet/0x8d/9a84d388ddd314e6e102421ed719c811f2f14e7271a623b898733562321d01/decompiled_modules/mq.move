module 0x8d9a84d388ddd314e6e102421ed719c811f2f14e7271a623b898733562321d01::mq {
    struct MQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MQ>(arg0, 6, b"MQ", b"TOKENOLUSTURMAYIN MQ", b"TOKEN OLUSTURMAYIN MQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.facebook.com/")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<MQ>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<MQ>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

