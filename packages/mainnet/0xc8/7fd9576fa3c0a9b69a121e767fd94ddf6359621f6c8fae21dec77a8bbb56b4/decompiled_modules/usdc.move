module 0xc87fd9576fa3c0a9b69a121e767fd94ddf6359621f6c8fae21dec77a8bbb56b4::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"Unicorn Sunset Dick Cloud", b"Unicorn Sunset Dick Cloud (USDC)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TG_8_Tnsx5_C_Reu_Z_Xq_A3_Se_Uj5r_Dd_TGWDX_1v_FZ_Botr_W_Qft18_e5fb975321.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

