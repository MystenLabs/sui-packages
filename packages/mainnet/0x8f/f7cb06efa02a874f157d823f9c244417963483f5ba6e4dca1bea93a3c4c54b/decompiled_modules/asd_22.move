module 0x8ff7cb06efa02a874f157d823f9c244417963483f5ba6e4dca1bea93a3c4c54b::asd_22 {
    struct ASD_22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD_22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD_22>(arg0, 6, b"ASD22", b"asdasd", b"asddddssad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-internal-do-not-share.hop.ag/")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<ASD_22>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<ASD_22>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

