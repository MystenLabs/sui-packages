module 0x47ce4ecd673d1331d2976124fcbdd05307e7ff89ecc15593007cfeda13aa52fd::scr {
    struct SCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCR>(arg0, 6, b"SCR", b"Scroll", x"5363726f6c6c20697320656d6261726b696e67206f6e20697473206669727374207374657020746f776172647320646563656e7472616c697a6174696f6e2e2020202020202020202024202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SCR_T_Hph_SP_r_NZ_Ury_Lo1_Iut_c2b7f4c126.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

