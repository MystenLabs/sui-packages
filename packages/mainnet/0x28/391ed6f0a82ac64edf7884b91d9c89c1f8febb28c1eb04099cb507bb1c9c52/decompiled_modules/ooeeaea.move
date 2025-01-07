module 0x28391ed6f0a82ac64edf7884b91d9c89c1f8febb28c1eb04099cb507bb1c9c52::ooeeaea {
    struct OOEEAEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOEEAEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOEEAEA>(arg0, 6, b"OoEeAEA", b"spinning pengu", x"70656e677520627261696e726f740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf2_Ftqv_Zk3t_Ae8fe7t_QA_Fuv_N2_Rw_Pfq_Stc_Bwi_Cb_EP_3dtea_cdf6e79237.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOEEAEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OOEEAEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

