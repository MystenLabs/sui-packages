module 0x5c4600f465b94849ee57ea611096bccc5ff6d4f4962ef2b52c6557de5267ef27::pixcat {
    struct PIXCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXCAT>(arg0, 6, b"PIXCAT", b"PIXCAT on SUI", b"pixel cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeeo85_P_Ybg_Y4_Qxjw_RE_Lna_Qk_Ra_C_Zo1_BH_1_J_Jenkc5_Nm_Vm_Jz_72c50e2077.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

