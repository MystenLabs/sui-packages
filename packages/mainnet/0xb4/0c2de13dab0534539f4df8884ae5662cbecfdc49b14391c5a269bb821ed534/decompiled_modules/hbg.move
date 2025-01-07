module 0xb40c2de13dab0534539f4df8884ae5662cbecfdc49b14391c5a269bb821ed534::hbg {
    struct HBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBG>(arg0, 6, b"HBG", b"Honey Badger", x"486f6e6579204261646765722028484247290a224272696e67206974206f6e2c20746865206d6f737420666561726c65737320616e696d616c20696e2074686520776f726c6474686520486f6e6579204261646765722e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042218_449a316cbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

