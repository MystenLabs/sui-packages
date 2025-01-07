module 0xaef0fbf87b63a1b8096818e502d8eb4ecce5896d7427c760d528e474c2df62ee::abes {
    struct ABES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABES>(arg0, 6, b"ABES", b"Abe On Sui", x"41626527732073686f727420666f7220416d65726963616e2042616c64204561676c652e2068747470733a2f2f6162656f6e7375692e6c6f6c0a68747470733a2f2f782e636f6d2f4142455f5355490a68747470733a2f2f742e6d652f4142455f537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rr_Hi_IQ_9_KO_Yd_Y_Rms_Y_Kb_Ph3q_Qcz_A_b4491f0a56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABES>>(v1);
    }

    // decompiled from Move bytecode v6
}

