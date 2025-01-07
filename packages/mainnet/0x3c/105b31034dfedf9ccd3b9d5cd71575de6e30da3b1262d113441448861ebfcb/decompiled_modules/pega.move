module 0x3c105b31034dfedf9ccd3b9d5cd71575de6e30da3b1262d113441448861ebfcb::pega {
    struct PEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEGA>(arg0, 6, b"PEGA", b"Giga Pepe", b"Giga Pepe for Max Gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yn6th_J39_BFBA_3vtr_C1n_Cge8_Xqarq_F2_Caf9p_N_Cq_Eh_H8hy_d62ca1f4e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

