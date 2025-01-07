module 0x6c91cf2b47ac04f030691c1c389ba20243499499e32eb82a894b127c1c62049b::sergio {
    struct SERGIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERGIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERGIO>(arg0, 6, b"Sergio", b"Sergio The Sea Lion", x"68747470733a2f2f7777772e74696b746f6b2e636f6d2f407075626974792f766964656f2f373433373637303835353838303036383338340a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Nr1sj_FC_3_G4_X25rw_Zarhou_V8w_Cmqe_UUR_Tm_MR_Ds4v3y_BS_f8e05ebe0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERGIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SERGIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

