module 0x4c407a20d8c7edfb3f4f910977a4ffe592f6f5da767e72f5a0e65d890822f850::hamfan {
    struct HAMFAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMFAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMFAN>(arg0, 6, b"HAMFAN", b"Lewis Hamilton", b"The Lewis Hamilton Fan Token (HAMFAN) is designed for devoted followers of the seven-time World Champion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_01_16_37_27_A_pixel_art_depiction_of_Lewis_Hamilton_using_detailed_blocky_pixels_to_capture_his_likeness_His_short_hair_facial_hair_and_confident_expression_13fccb21db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMFAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMFAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

