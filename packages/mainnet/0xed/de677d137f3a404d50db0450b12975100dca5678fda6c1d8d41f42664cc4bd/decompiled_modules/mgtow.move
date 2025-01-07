module 0xedde677d137f3a404d50db0450b12975100dca5678fda6c1d8d41f42664cc4bd::mgtow {
    struct MGTOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGTOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGTOW>(arg0, 6, b"MGTOW", b"Men Going Their Own Way", x"756e626f7468657265642c2073656c662d73756666696369656e742c2066756c6c7920696e646570656e64656e740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QR_Xr_YS_Zqs5_AS_76_Rr_Bpe_Q_Xa_Q1fn7x67_Lu26_Rha_Jqp_Kb_Nw_2a3552d5d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGTOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGTOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

