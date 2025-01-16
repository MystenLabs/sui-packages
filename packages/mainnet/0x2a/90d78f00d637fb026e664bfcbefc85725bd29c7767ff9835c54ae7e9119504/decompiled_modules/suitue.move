module 0x2a90d78f00d637fb026e664bfcbefc85725bd29c7767ff9835c54ae7e9119504::suitue {
    struct SUITUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITUE>(arg0, 6, b"SUITUE", b"Thich Minh Tue", x"54686520617573746572652044687574616e67612070617468206f66204275646468697374206d6f6e6b205468696368204d696e68205475652068617320696e73706972656420646576656c6f7065727320746f206372656174652061206d656d6520636f696e206e616d656420696e2068697320686f6e6f722e205468697320756e697175652070726f6a65637420636f6d62696e6573207468652073706972697475616c206469736369706c696e65206f662073696d706c696369747920616e64207065727365766572616e63652077697468207468652064796e616d696320656e65726779206f66207468652063727970746f20776f726c64210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaj7_N_Asx1_N_Sph7ku_Ei_RGBKR_Eb_FX_8_E_Kf_Xq3_C_Vry_H_Tx_Fx4_P_fa43a4ff6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

