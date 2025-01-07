module 0xfea847341a3bb294e290636312a2b312c36eaa0fcef6489ab344b56e10e5cfe3::um_salve_para_o_elcartel_e_tambem_para_o_snk {
    struct UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK>(arg0, 6, b"UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK", b"UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK", b"telegram: elcartelounge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/6U2Banh.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK>>(v1);
        0x2::coin::mint_and_transfer<UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UM_SALVE_PARA_O_ELCARTEL_E_TAMBEM_PARA_O_SNK>>(v2);
    }

    // decompiled from Move bytecode v6
}

