module 0x1d02343c4e67203e49e83ba0c02f9b0cf10fd0ac0980bd1efbaf8913e0a2b54b::ur {
    struct UR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UR>(arg0, 6, b"UR", b"Unicorn Run", x"5468697320636f726e2063616e2072756e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T_Afhfma6_Az_Rqnb_H_Zx_Kq_Smxdat_Fm_ZAFK_1_S1pfx_RYAH_Ff_G_e1b529dd4c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UR>>(v1);
    }

    // decompiled from Move bytecode v6
}

