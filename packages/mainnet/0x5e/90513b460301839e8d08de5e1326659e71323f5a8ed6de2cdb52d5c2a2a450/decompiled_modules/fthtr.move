module 0x5e90513b460301839e8d08de5e1326659e71323f5a8ed6de2cdb52d5c2a2a450::fthtr {
    struct FTHTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTHTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTHTR>(arg0, 6, b"FTHTR", b"fake tether", b"fake tehter attempt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hop.ag/tokens/USDT.webp")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<FTHTR>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<FTHTR>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

