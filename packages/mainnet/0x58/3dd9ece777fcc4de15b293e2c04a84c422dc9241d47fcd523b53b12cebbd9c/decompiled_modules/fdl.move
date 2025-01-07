module 0x583dd9ece777fcc4de15b293e2c04a84c422dc9241d47fcd523b53b12cebbd9c::fdl {
    struct FDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDL>(arg0, 6, b"FDL", b"fake dollar", b"this is not really a dollar just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hop.ag/tokens/USDC.webp")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<FDL>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<FDL>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

