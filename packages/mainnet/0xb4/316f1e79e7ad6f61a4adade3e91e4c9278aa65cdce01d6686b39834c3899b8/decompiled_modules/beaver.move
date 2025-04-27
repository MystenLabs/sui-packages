module 0xb4316f1e79e7ad6f61a4adade3e91e4c9278aa65cdce01d6686b39834c3899b8::beaver {
    struct BEAVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAVER>(arg0, 6, b"BEAVER", b"SUI BEAVER", x"626561766572206f6e2073756920636861696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BEAVER_26ddeb1edc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

