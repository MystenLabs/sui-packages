module 0x54f2c9f6607963c939243c826a1e637e51c1132ca49e5f7a4a2da76b1d013cce::art {
    struct ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ART>(arg0, 6, b"ART", b"art", b"atrt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://petshop.app/")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<ART>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<ART>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

