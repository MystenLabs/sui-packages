module 0xb7e28f593db8a33fdb407297ba7d3238f0383f32af188796ca105c039de39c3a::kichi {
    struct KICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KICHI>(arg0, 6, b"KICHI", b"Kichimori", b"Cute Chinese dog sleeping in a scarf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ysv9g_JWMAA_qx_K_0ade328b99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

