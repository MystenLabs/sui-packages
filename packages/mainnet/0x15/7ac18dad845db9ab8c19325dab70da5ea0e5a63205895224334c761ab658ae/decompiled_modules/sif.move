module 0x157ac18dad845db9ab8c19325dab70da5ea0e5a63205895224334c761ab658ae::sif {
    struct SIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIF>(arg0, 6, b"SIF", b"Sui Stonkwifhat", b"Just Stonks, but with a hat $SIF.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Mm5ug_ZQJ_8k_YGX_Uh_Hj_Ttv_S_Mgs_Za_Ruv_Erdz_CU_8_Nmo_Mf_RF_6f65e1ee5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

