module 0x45048daa02633de9137675ae9d20b3441bc7748569a12c0d926ea2f5ff0f18c7::czcat {
    struct CZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZCAT>(arg0, 6, b"CZCAT", b"CZ CAT", b"Mk BNB gret agen! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EWQG_Hdo1au9_G_Zn_Lt7j7i_HB_8s_Buo5_Pk_RD_Ps_RVG_Fjipump_d1ed7c3c2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

