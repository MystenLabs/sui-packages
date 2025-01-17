module 0x61a8147c6ecf4b6c0bbb6dd9fb9bd5bda0af17f95a4c064cdfdebe3e672e4f9a::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"TEMU TRUMP", x"54454d55205452554d500a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma6_Gt_E_Mue_D3r_Un_C_Qonjpz_H6bh_Bwdjh_Ri7ji_TE_1_Es_Fq_A7f_1fac8c9a7b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT>>(v1);
    }

    // decompiled from Move bytecode v6
}

