module 0x5dd8f00125c67403c56c9eb9a3c4743b9e43b1f8bb235918b8ad9fc64c4129b0::catwiz {
    struct CATWIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWIZ>(arg0, 6, b"CATWIZ", b"cat wizard", b"Alarte Ascendare", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bd3027d7_4467_4706_9073_b0d1cb01556f_c85a726a05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATWIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

