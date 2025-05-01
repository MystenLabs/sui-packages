module 0xe3a7789f4efbd91aaea7faedf334545e91c696c4cc19ab9add070ae38484cad8::plm {
    struct PLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLM>(arg0, 6, b"PLM", b"Polymarket", b"You can now understand all power of MEME ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_49_fe8904c281.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

