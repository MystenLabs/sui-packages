module 0xdd4de6c65b1fe860f88f64b30442de1d6ba5c1ac389b197890b879844157426f::trumpborg {
    struct TRUMPBORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBORG>(arg0, 6, b"TRUMPBORG", b"TrumpBorg", b"Trumpborg came back from the far future to save Humanity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_mpvepump2_ezgif_com_gif_to_webp_converter_c512fd4311.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPBORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

