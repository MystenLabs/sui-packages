module 0x15d5d23c018782dd4dd969d558fc6f522c38df340493d6a5b291122c58f45f43::wfish {
    struct WFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFISH>(arg0, 6, b"wFISH", b"wrapped fish", x"7772617070656420646f67206f6e20534f4c3a203134206d696c6c696f6e204d430a0a777261707065642066697368206f6e205355493a203330206d696c6c696f6e204d43", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Pantalla_2024_10_11_a_la_s_17_49_10_b7814fdd4e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

