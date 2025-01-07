module 0x3fb700ac7b448e81a42c58502995de93a12c1bbee6836d443440abfdb4fbbd68::babyshark {
    struct BABYSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSHARK>(arg0, 6, b"BABYSHARK", b"Baby Shark", b"The cutest fish in the crypto sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_02_17_50_41_A_more_cute_and_adorable_logo_for_Baby_Shark_Coin_featuring_a_cartoon_style_baby_shark_with_bright_and_soft_colors_focusing_on_blues_and_yellows_T_167081accf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

