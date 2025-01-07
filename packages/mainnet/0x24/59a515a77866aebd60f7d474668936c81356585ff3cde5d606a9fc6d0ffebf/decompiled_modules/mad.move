module 0x2459a515a77866aebd60f7d474668936c81356585ff3cde5d606a9fc6d0ffebf::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAD>(arg0, 6, b"MAD", b"MAD On Sui", b"$MAD - The Wild Degen who hustles hard and parties harder ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mad_Hpj_Rn6bd8t78_Rsy7_Nu_Su_Nw_Wa2_HU_8_By_Pob_Zpr_Hb_Hv_0fde47448d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

