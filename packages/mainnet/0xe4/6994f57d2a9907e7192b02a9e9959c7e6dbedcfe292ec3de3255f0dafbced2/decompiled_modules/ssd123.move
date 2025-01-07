module 0xe46994f57d2a9907e7192b02a9e9959c7e6dbedcfe292ec3de3255f0dafbced2::ssd123 {
    struct SSD123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSD123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSD123>(arg0, 6, b"SSD123", b"HABAS", b"SUIGMA1923", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730911187963.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSD123>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSD123>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

