module 0x620189f5c1232a756c94e0aa7c749e394c475895693122335a2870fe70a54692::koala {
    struct KOALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOALA>(arg0, 6, b"KOALA", b"KOALA SUI", x"49276d20244b4f412149276d205065706527732062657374696520666f72207265616c210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_N_Zn_M_Uc_400x400_84fb3931fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

