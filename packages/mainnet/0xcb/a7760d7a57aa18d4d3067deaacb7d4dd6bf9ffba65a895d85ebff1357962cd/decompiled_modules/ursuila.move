module 0xcba7760d7a57aa18d4d3067deaacb7d4dd6bf9ffba65a895d85ebff1357962cd::ursuila {
    struct URSUILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: URSUILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URSUILA>(arg0, 6, b"URSUILA", b"Ursuila", b"FRIDAY THE 13TH IS JUST THE BEGINNING  //  BURN 13% IN DEX!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_ezgif_com_video_to_webp_converter_731431175a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URSUILA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URSUILA>>(v1);
    }

    // decompiled from Move bytecode v6
}

