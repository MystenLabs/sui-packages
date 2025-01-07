module 0x81781171ec46a19361298fb73c21ea116f822ac6a1e3c545e0e05d26ee298b60::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGG>(arg0, 6, b"GGG", b"ggg", b"FFHXN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5bf20540b18376a0c53adc382eead659_4d2b1590f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

