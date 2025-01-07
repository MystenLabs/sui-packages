module 0xaab2eb33dca216ac3cb4609252161533d5b325eea3159b3ec510e361687fa2b5::psau {
    struct PSAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSAU>(arg0, 6, b"PSAU", b"PumpSaurus", x"50756d70536175727573202074686520636f696e2074686174206469646e277420676f20657874696e63742c20697420746f6f6b206f6666210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PSAU_TG_2_Gg_K_VM_Gho0u_EYM_3_S_c0d4827c32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

