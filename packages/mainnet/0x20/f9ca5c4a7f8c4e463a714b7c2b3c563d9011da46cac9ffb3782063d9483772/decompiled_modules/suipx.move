module 0x20f9ca5c4a7f8c4e463a714b7c2b3c563d9011da46cac9ffb3782063d9483772::suipx {
    struct SUIPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPX>(arg0, 6, b"SUIPX", b"SuiPX6900", x"2453554950583a20464c495050494e47205448452053544f434b204d41524b4554207c204e6f77206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_meme_1_b24f4101b4_a2f3d7f0df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

