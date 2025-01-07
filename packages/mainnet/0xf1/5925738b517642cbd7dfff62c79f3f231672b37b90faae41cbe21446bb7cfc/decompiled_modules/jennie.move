module 0xf15925738b517642cbd7dfff62c79f3f231672b37b90faae41cbe21446bb7cfc::jennie {
    struct JENNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENNIE>(arg0, 6, b"JENNIE", b"First Realistic AI Dog", x"4a656e6e69652069732074686520776f726c642773206d6f7374207265616c697374696320726f626f74696320656d6f74696f6e616c20737570706f727420616e696d616c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmci_G2c4_K4r4n4n_Z8b_B_Gh_Vb_W4_T_Bb8_Yk_Gg_Zwh_Czg_Usg_G_Pr_H_0f0a67c74b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JENNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

