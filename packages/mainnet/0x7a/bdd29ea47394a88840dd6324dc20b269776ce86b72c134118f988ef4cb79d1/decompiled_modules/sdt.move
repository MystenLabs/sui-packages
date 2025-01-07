module 0x7abdd29ea47394a88840dd6324dc20b269776ce86b72c134118f988ef4cb79d1::sdt {
    struct SDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDT>(arg0, 6, b"SDT", b"Sui Dancing Trump", b"Just a spinning dancing Trump on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tokengif_gif_ezgif_com_video_to_gif_converter_4ed987ef5b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

