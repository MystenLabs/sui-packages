module 0x75129fcb32cec8f8817b47cde71d8b9d9dff3eef1f1f910d859ade83e0f86c96::bookofsui {
    struct BOOKOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKOFSUI>(arg0, 6, b"BOOKOFSUI", b"BOOK OF SUI", b"BOOK OF SUI, ALL MEMES IN BOOK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0159_B4_D7_CF_3_F_44_CA_91_B7_94_D8_AABC_2783_3662571a4e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKOFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKOFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

