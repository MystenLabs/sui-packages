module 0xb7c078c4187fbabe9498e81e4313e5073492c50908c1c5599499eb3f97654d41::greekai {
    struct GREEKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEKAI>(arg0, 6, b"GREEKAI", b"GREEK", b"THE GREEK GOD OF AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_04_17_37_54_0dd8e16b78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREEKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

