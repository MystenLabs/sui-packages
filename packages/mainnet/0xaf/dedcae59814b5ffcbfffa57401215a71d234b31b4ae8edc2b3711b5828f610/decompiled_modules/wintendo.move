module 0xafdedcae59814b5ffcbfffa57401215a71d234b31b4ae8edc2b3711b5828f610::wintendo {
    struct WINTENDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTENDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTENDO>(arg0, 6, b"WINTENDO", b"Truth Terminal WINTENDO", b"Truth Terminal WINTENDO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_22_A_s_16_47_09_ed84526f_f14a5e2d07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTENDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTENDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

