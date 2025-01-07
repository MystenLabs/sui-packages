module 0x7aba9f266d7a70c1eb42f14a3e0fcf54f62a24ebcce7917f4b920d668c1cc246::chuddha {
    struct CHUDDHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUDDHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUDDHA>(arg0, 6, b"CHUDDHA", b"Chuddha Sui", x"226e6f7468696e6720657665722068617070656e73220a2022627574206368756464612c20776861742069662d22200a22697420776f6e27742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmec_VGLL_Ba_J_Mg_JU_7n5_B4e_K_Ab_XTXM_3_A8o9j49_B_Bujv_Ect_Qp_34fcf5ce55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUDDHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUDDHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

