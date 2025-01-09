module 0xf74fc98d752577e95871480ba699e942ca5e0b33f1a54e9daa974556e2c4aa5d::aidlm {
    struct AIDLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDLM>(arg0, 6, b"aiDLM", b"Degenerate Language Model", x"446567656e6572617465204c616e6775616765204d6f64656c2024444c4d207c2041206c616e6775616765206d6f64656c206275696c7420666f722073686f77696e672041692074686520646567656e65726174697665206265686176696f72206974206e6565647320746f2066697420696e20776974682074686520417065696e6720637261796f6e20656174696e6720444547454e530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Utn67c2kwsinf_CC_1r_TGT_Gtimt_T_Cgb_Bvu_Wjc1_Sv7_J_Za9_C_0526dcce6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

