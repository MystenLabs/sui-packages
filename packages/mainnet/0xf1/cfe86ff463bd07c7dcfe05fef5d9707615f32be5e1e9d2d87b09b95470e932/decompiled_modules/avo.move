module 0xf1cfe86ff463bd07c7dcfe05fef5d9707615f32be5e1e9d2d87b09b95470e932::avo {
    struct AVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVO>(arg0, 6, b"AVO", b"avocato", b"31", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.tenor.com/MdfYLyL-PCIAAAAe/avocato-final-space.png")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<AVO>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<AVO>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

