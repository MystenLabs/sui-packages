module 0xa556cddfd3bfb8553852f1c9db01112c0c423a487ed3bf98463c4eeeb1e08ca5::ishi {
    struct ISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHI>(arg0, 6, b"ISHI", b"Ishi Sui", x"2449534849202d2054686520416e636573746f72206f6620536869626120496e750a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nakamigos_83976c2e81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

