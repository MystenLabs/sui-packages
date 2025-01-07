module 0x8b91a1730718809469c43b5d91a5d3ef49d52984e65aa86b83955796a0ca6cf8::gingcat {
    struct GINGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINGCAT>(arg0, 6, b"GINGCAT", b"Ginger Cat", b"Everybody needs a ginger cat at Christmas time. Get yourself a Christmas Ginger Cat coin and imagine you have a ginger cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_R_Dh_Cv8x_sl1zvt_Ezd_MB_Hl_M_Ri_M_bc7ac4a3a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

