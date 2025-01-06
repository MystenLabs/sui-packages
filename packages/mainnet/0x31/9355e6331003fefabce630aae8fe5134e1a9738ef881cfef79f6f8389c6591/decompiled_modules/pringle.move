module 0x319355e6331003fefabce630aae8fe5134e1a9738ef881cfef79f6f8389c6591::pringle {
    struct PRINGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINGLE>(arg0, 6, b"PRINGLE", b"Pringle The Duck", b"Pringle The Duck is tired of Rugs, and Scams. Pringle has had enough. LORE: Pringle is PEPEs favorite pet, he got his name because PEPE thought his beak looked like Pringle. Website: Yes, Socials: Yes, Pump: Yes, Original Character: Yes, Can Ducks Fly: Yes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wpv_Mdb_T7_Jj_Je_Q_Pmqs_Yj3ex_Nis7_X_Yctd_Qb_MC_Ye_J_Duuwwz_4958600fe7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRINGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

