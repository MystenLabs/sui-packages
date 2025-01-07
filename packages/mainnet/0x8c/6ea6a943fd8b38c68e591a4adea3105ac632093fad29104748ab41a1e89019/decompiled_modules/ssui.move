module 0x8c6ea6a943fd8b38c68e591a4adea3105ac632093fad29104748ab41a1e89019::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSUI", b"Sexy Sui", b"Sexy time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6240713e_c6ed_44fd_994c_2c1f796d11a2_e2b055d3f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

