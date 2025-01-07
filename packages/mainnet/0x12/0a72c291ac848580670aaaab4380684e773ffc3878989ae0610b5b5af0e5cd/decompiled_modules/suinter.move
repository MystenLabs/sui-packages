module 0x120a72c291ac848580670aaaab4380684e773ffc3878989ae0610b5b5af0e5cd::suinter {
    struct SUINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINTER>(arg0, 6, b"SUINTER", b"Suinter Arc", b"Lock in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/122215_ezgif_com_video_to_gif_converter_4_8be36e4d86.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

