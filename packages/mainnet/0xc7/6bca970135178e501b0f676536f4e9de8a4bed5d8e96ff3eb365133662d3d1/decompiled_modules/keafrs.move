module 0xc76bca970135178e501b0f676536f4e9de8a4bed5d8e96ff3eb365133662d3d1::keafrs {
    struct KEAFRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEAFRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEAFRS>(arg0, 6, b"KEAFRS", b"KEKWES", b"ASFASDFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/gamblecatonsol")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<KEAFRS>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<KEAFRS>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

