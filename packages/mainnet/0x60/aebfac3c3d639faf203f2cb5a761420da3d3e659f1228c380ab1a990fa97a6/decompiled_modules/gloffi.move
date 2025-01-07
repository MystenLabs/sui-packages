module 0x60aebfac3c3d639faf203f2cb5a761420da3d3e659f1228c380ab1a990fa97a6::gloffi {
    struct GLOFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOFFI>(arg0, 6, b"Gloffi", b"Gloffi-Oh", b"Gloffi-Oh has pink coloured skin. The animal has a trunk with purple spots to help it eat. The animal has two black eyes on the sides of its trunk. Visually, Gloffi-Oh resembles an earthbound elephant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6acf48a2_e4ef_4322_a43e_761e633a4b6f_804f20e934.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

