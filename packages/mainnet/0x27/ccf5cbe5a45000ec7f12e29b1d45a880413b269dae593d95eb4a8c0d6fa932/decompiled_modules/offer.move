module 0x27ccf5cbe5a45000ec7f12e29b1d45a880413b269dae593d95eb4a8c0d6fa932::offer {
    struct OFFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFFER>(arg0, 6, b"OFFER", b"Offer Cat", b"@offercat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T_Wug8a_GY_Mv_Chgg_UN_Eq7_KV_Cm_Ntb_H18vf_J1d_We_X_Vm_T2_Lou_e1c20d8b0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

