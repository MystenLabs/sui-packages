module 0x1590819df2fc22b4a04b8adf64bec52ebb0c519ada0e92edc163f0fa39422cf9::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFT>(arg0, 6, b"NFT", b"Non Fungible Todd", b"$NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rf_HZJJG_Gk27bf8b_Hc_EPQ_Rv_Z_Dx_Pj_SUGY_9_Kc2z83_AC_Qgp_F_e8f46b4bcd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

