module 0xb718c2174aaf8221242ad5b582009e167f065dd70d1accc4633ef6d73865ddf4::ogg {
    struct OGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGG>(arg0, 6, b"Ogg", b"MemeOgg", b"MemeOggON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tqdo1_FW_7yo_Jxe_Gw_ZE_3_Btugbr_D_Zv_Vem_Vj36fmxp_TXA_Nf_B_221a5dc0ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

