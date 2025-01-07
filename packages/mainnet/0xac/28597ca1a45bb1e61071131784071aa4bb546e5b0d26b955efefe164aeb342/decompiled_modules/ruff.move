module 0xac28597ca1a45bb1e61071131784071aa4bb546e5b0d26b955efefe164aeb342::ruff {
    struct RUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFF>(arg0, 6, b"RUFF", b"Sui RUFF", x"4a7573742052756666696e272041726f756e640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_K_Xs_AG_4st_Rdup_Ke1_Fw4h9kq4vg_T4_Uxnta_B_Rj_Ppu_U_Hex2_b2ef0d1e27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

