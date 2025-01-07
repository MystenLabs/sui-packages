module 0x1edb18d142107b413cacc5aeafa7bb68cf3e8d721b9b4f42b3c8758a11d880d2::bowie {
    struct BOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWIE>(arg0, 6, b"BOWIE", b"Bowie", x"456c6f6e204d75736b20466972737420446f67202d2024424f574945200a0a41726368697665203a2068747470733a2f2f617263686976652e6f72672f64657461696c732f656c6f6e2d6d75736b2d62792d77616c7465722d6973616163736f6e2f706167652f6e35352f6d6f64652f3275703f713d626f776965200a0a54776974746572203a2068747470733a2f2f782e636f6d2f456c6f6e4d75736b426f7769652f7374617475732f313834363138393138353132393931303338360a0a54656c656772616d203a20742e6d652f656c6f6e6d75736b626f7769650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_16_58_41_2_89744435b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

