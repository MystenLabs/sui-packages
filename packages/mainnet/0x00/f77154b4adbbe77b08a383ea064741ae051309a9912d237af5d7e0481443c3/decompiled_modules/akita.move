module 0xf77154b4adbbe77b08a383ea064741ae051309a9912d237af5d7e0481443c3::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on SUI", b"AKITA on the wave!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_ND_6_Z72nj_Sukw_Kh_c5537d90dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

