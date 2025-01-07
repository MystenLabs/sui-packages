module 0x504da84831605a662df1a5a1112433c02836ff3e7bf8363f37795d71dd55e260::kobi {
    struct KOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBI>(arg0, 6, b"KOBI", b"Kobi Mentality", b"Mamba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Prh9_Chi_Lh_C_Dj8_P_Neogy_NN_4184_H3_FF_Xc_Mg_Vhe_HAH_3gv_Fk_d5f416fad3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

