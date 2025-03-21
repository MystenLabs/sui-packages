module 0xd5f75bf31751eb9d165fbc796157b17c54ec2c59f135a30c2696aa71b1d25e53::gai {
    struct GAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GAI>(arg0, 6, b"GAI", b"Genius AI ", b"Genius AI is a next-generation intelligent assistant designed to simplify complex tasks and unlock human potential. With advanced AI capabilities and a user-friendly interface, it delivers tailored solutions for business, education, finance, and well-being.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000169818_12f8116573.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

