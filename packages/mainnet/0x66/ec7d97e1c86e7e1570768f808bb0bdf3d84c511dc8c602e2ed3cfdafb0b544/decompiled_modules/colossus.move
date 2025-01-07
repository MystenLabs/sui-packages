module 0x66ec7d97e1c86e7e1570768f808bb0bdf3d84c511dc8c602e2ed3cfdafb0b544::colossus {
    struct COLOSSUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLOSSUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLOSSUS>(arg0, 6, b"Colossus", b"The Worlds Largest AI", b"The Worlds Largest AI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Weqdux_Kr_L_Hia_ND_Gic_C_Cor_Mk_S_Dk_Tt_Y1o_Hd_V249qm_Wi_Ep_444023eaef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLOSSUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLOSSUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

