module 0x4552cc40552ef50450d88ffc44b94799acfd2acb8e4465eaab31a9756eb9f410::neirai {
    struct NEIRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRAI>(arg0, 6, b"neirAI", b"NEIRO ai", x"4e4549524f206f6e2053554920697320616c6c20796f75206e6565642c20666f722073756363657373210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_J3gc2_T7_H3_Lz8f34_J65yd_Rw_Dm_TW_Kg_PR_4_DJ_Ma1_B1gpump_3638853342.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

