module 0x5584d467437931159102477d02d02691772b9f374df1d0b20115130e550b513e::wawa {
    struct WAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWA>(arg0, 6, b"WAWA", b"Mr Hyrax", b"Meet Hyrax, the adorable, quirky creature that brings laughter and energy to your crypto journey. Known for his signature WA-WA! sound, hes not just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Yud_J8n_Ge_Fe_Nfe_M7_H_Hq_Uz_H_Kw_Ns_Xt_CC_39dwu_Bsfuf_Pc_Bd_297e54b1ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

