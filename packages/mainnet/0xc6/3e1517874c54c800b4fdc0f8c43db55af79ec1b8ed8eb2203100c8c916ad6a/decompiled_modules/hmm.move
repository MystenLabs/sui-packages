module 0xc63e1517874c54c800b4fdc0f8c43db55af79ec1b8ed8eb2203100c8c916ad6a::hmm {
    struct HMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMM>(arg0, 6, b"HMM", b"hmm", b"what?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hop.ag/")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HMM>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HMM>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

