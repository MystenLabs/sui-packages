module 0xdc1d034a721014e02643662b5e3e0e23afd626a19657560d03e283f07c7efb6c::dro {
    struct DRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRO>(arg0, 6, b"DRO", b"DRAGONDRAGON", b"FIRST DRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.resimlink.com/rSacO9Z.jpg")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<DRO>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<DRO>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

