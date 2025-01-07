module 0x8a5924923658eefd3a52c43a34913d6b27fc5d3f4b39cb560eee35bd41a0b37::pookie {
    struct POOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKIE>(arg0, 6, b"POOKIE", b"Pookie", x"504f4f4b49452028504f4f4b4945290a416e64207468652063757465737420626572612e204772616220796f7572206861742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZMAX_5o_B_Yut_R8n_Hgp_RT_Jd6_Xf_Secrcyuy_ZY_9j_A7o_M3ojcd_a4201936dd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

