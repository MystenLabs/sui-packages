module 0xbe8bc96695ec651fd15ac8ada9f56392c9d3e0be41a671cc57010ce17ca432a::truear {
    struct TRUEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUEAR>(arg0, 6, b"TRUEAR", b"Official Trump Ear", b"The official ear of Donald Trump, the 47th President of the United States ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ezgif_com_video_to_gif_converter_c125d0c5d9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

