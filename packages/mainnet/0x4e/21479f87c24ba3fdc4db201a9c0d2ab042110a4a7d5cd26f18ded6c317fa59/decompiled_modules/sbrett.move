module 0x4e21479f87c24ba3fdc4db201a9c0d2ab042110a4a7d5cd26f18ded6c317fa59::sbrett {
    struct SBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRETT>(arg0, 6, b"SBRETT", b"Santa Brett on Sui", x"0a4974732042726574742066726f6d20426f797320436c75622c20627574206e6f77206865732073706f7274696e6720612072656420737569742c20726f636b696e67207468652053616e74612076696265732c20616e64206272696e67696e6720646563656e7472616c697a656420686f6c6964617920636865657220746f20616c6c2053756920646567656e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dy_Nz_Dv2_Jw1phx_Cdkt_R_Cbq_LF_45udf_YG_6_FQ_Eo_Wnj_Smpump_5c8bf9e109.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

