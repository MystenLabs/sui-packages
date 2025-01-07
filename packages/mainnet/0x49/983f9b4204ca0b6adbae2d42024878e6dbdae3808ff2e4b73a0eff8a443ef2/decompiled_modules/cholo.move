module 0x49983f9b4204ca0b6adbae2d42024878e6dbdae3808ff2e4b73a0eff8a443ef2::cholo {
    struct CHOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOLO>(arg0, 6, b"CHOLO", b"El Cholo Cat", b"miao juey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dr_H_Ez3_Pdz_QU_Ktz6cs_Uy_Dh1te_Unwk_H_Uz32e_Vnzd_Pq2k6y_8ba899516d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

