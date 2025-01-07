module 0xadb5f20e26942b64e091609707e5cc8984bdfb919ea69cb66d4e92de8cef6117::biff {
    struct BIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIFF>(arg0, 6, b"BIFF", b"biff the bear", b"First bear to land on the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Zm6n_U_Vnpm_Tu_Zja_Gj_PY_Jp_S_Dvs4s_Baw_F9_E_Vg_EKA_2_M_Qs_Ta_71e5248afa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

