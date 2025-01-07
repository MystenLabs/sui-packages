module 0xc08e80f4d855b8fead3d4e9153d51c86fc89ca55fa83196de7e6a84ea0790dac::soomer {
    struct SOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOMER>(arg0, 6, b"SOOMER", b"SUI SOOMER", b"Deep down, he scrolls through MovePump, high on adrenaline and ambition, invest a bunch of coins only to lose his last pieces of SUI in a single day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_6_7589b76ac4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

