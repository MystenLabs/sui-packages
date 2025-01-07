module 0x1e215a81ab850e8c1461bdb78bedfe53691594cb5bf0c978fd4edc64d7eaeb22::popdog {
    struct POPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOG>(arg0, 6, b"POPDOG", b"POPDOG ON SUI", b"POPDOG is now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H9_BC_Hf_J5n_K8c4fd_N5_E_Xi_EYK_Hjf_F_Mn_E_Ldw9bpr_Bpepump_6e7d59d86d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

