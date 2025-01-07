module 0x836f1a15ae9d244fe9a8fcfa8622a46c91d7edb84a48a27fadfd5ae9cd168f64::sniff {
    struct SNIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIFF>(arg0, 6, b"SNIFF", b"Sombra The Drug Dog", b"Sombra the drug-sniffing police dog is famous in Colombia. Now smugglers have put a bounty on her head. we are here to protect her in the Sui Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaxg_E6yap_Vv_C_Jkx_MX_6_Rd_EC_8r_NMW_29_UU_Mq_Jxyc_JMB_2gv3z_161c0d2a01.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

