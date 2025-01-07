module 0x9276b49deac94169daab32c1b7961d7f578909568ad7c7ea5e56e0db86e854ae::goldendog {
    struct GOLDENDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDENDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDENDOG>(arg0, 6, b"GOLDENDOG", b"Golden Dogs", b"Cane d'oro di Satoshi Nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016581_56d2928621.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDENDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDENDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

