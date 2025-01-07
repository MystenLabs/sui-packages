module 0xcb2034b97e90f1a42983d3d9ef0b0f8a9caf06ccaa71b36edaac2b1eb752e513::rcat {
    struct RCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCAT>(arg0, 6, b"RCAT", b"Repost Cat", b"RCAT on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_Cbbg_Vc_Pcgb_G1r_Jidrp_Dm_Kz_Zpf_GKH_7_Bpcmam8o1vpump_eab45110d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

