module 0xe3aff4d60381fcc11d5962e4330043fdb47fb10fb2c7498e6c3c0680eaba295b::marsplanet {
    struct MARSPLANET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSPLANET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSPLANET>(arg0, 6, b"Marsplanet", b"Mars", b"Mars (planet)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mouse_T_Au_Rqr_SH_Ngyoyv_AA_Hi_0e7f31942e_8adb126b9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSPLANET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARSPLANET>>(v1);
    }

    // decompiled from Move bytecode v6
}

