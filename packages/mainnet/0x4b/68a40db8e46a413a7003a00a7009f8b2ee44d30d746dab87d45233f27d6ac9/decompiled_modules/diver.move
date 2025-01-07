module 0x4b68a40db8e46a413a7003a00a7009f8b2ee44d30d746dab87d45233f27d6ac9::diver {
    struct DIVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVER>(arg0, 6, b"DIVER", b"SuiDiver", b"Dive into the SUI (NFT COLLECTION)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/240_F_819315708_ZN_Hu_I_Ctxt_T5_G_Gu_Nmv9_Ipl_Pmras_Nv00_Q7_f275571d4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

