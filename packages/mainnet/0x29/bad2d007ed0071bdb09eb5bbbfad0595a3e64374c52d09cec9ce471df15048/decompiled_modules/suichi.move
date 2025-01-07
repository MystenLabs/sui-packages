module 0x29bad2d007ed0071bdb09eb5bbbfad0595a3e64374c52d09cec9ce471df15048::suichi {
    struct SUICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHI>(arg0, 6, b"SUICHI", b"SUICHIKO", x"24535549434849202d205355494348494b4f204953204120204d454d45434f494e20444f47204f4e205355492057495448204e4f2020494e5452494e5349432056414c55450a0a4e4f204445560a4e4f205447200a4e4f2054574954544552200a4e4f2057454253495445200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_1_c61eddd330.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

