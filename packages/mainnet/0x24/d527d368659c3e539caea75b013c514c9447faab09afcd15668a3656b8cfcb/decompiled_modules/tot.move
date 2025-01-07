module 0x24d527d368659c3e539caea75b013c514c9447faab09afcd15668a3656b8cfcb::tot {
    struct TOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOT>(arg0, 6, b"ToT", b"cookies", x"5461746520636f6f6b6965732e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SPN_Vm75t2z2x_U6y4s_H_Wk_CR_Pg65_Smgdu_Sa3p_LC_Zfw_Wnre_3940680be5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

