module 0x29af4ddad4409d6d9de0b9b030cbd3cf76e27dcfa356c24bb8273526fc689e45::pogo {
    struct POGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGO>(arg0, 6, b"POGO", b"Pogo", x"4d65657420506f676f2c20746865206261736564206d6f6e6b6579207377696e67696e67207468726f7567682074686520626c6f636b636861696e206a756e676c6521205769746820626f756e646c65737320656e6572677920616e642061206b6e61636b20666f722066756e2e204a6f696e2074686520616476656e7475726520616e642067726162206120676f6c64656e2062616e616e61206173207765206578706c6f726520746865206578636974696e6720776f726c64206f662063727970746f20746f6765746865722120504f474f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S_Gz_V4_Dj_M_Qjed1o_Ni_BEF_Qdq_WC_Zp_MF_2ttn_W_Dtocff_Zp_K_Cr_5a68a8e3da.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

