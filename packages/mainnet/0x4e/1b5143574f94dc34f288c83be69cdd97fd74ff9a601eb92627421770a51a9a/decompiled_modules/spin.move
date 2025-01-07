module 0x4e1b5143574f94dc34f288c83be69cdd97fd74ff9a601eb92627421770a51a9a::spin {
    struct SPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIN>(arg0, 6, b"SPIN", b"chick spin wifhat", x"6261776b206261776b206261776b206261776b206261776b206261776b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbgq_Ee_Q_Xmwf4g2x_Wu54e_Np_D5_Y7ehe9nd4_GUAW_Wbjxh9_CG_105b66ac5a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

