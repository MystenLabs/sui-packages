module 0x5242cb8e922f356f52deb330d54069e7cc0931b5b1c28c41f5ff29d928a0b5f6::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"SUINIC ON SUI", b"Suinic moon, no pepe moon Suinic moon today i s a Suinic da y toda i Suinic moon. yes Suinic go to da moon. u is cuming wif Suinic?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P2vd_T4dr_K1_Y8qf_Kyc_Ff_Ha_M66ma94g9e7q_Nw522e6_Sj_KC_80d25a0ca0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

