module 0x6df3f67f4443cd0889ee0fb38c86c1f960bf48343658c137d97a910b43ca9a7e::pwr {
    struct PWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWR>(arg0, 6, b"PWR", b"PEPE WAR", b"All token on Dev Will burn 100%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004562_0e675ec2c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

