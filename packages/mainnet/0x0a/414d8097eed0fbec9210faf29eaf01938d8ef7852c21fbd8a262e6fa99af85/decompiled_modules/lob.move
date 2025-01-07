module 0xa414d8097eed0fbec9210faf29eaf01938d8ef7852c21fbd8a262e6fa99af85::lob {
    struct LOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOB>(arg0, 6, b"LOB", b"LOBSTER", b"THE NEW HYPE OF THE RICH LOBSTER. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_13_22_24_45_A_logo_for_a_cryptocurrency_called_LOBSTER_LOB_designed_with_a_retro_1970s_1980s_aesthetic_featuring_pastel_colors_The_central_figure_is_a_lobste_5dbecef9a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

