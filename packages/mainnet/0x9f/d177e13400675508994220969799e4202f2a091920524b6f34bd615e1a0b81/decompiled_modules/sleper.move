module 0x9fd177e13400675508994220969799e4202f2a091920524b6f34bd615e1a0b81::sleper {
    struct SLEPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEPER>(arg0, 6, b"SLEPER", b"LEPER SUI", b"Hi! I'm Larry, the lucky fckn' degen on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gs_Ebfbyjjn_YZGM_Sk_Xhoxrq_Tyrzd_YC_5_A_Fc_Cis_S51_JEGEE_cb5ea97be4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

