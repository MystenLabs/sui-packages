module 0x3aeaec191d36d4ac647f7a39ab88616131b309d5f600edbe7a6da12bcd0a4e13::akatsui {
    struct AKATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKATSUI>(arg0, 6, b"AkatSui", b"Akatsui", b"Rising from the shadows of the SUI network, AkatSUI brings a rebellious spirit and unstoppable energy to the memecoin arena, uniting believers in a mission to break the mold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Welcomeakatsui_ezgif_com_video_to_gif_converter_6_b4790133f1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

