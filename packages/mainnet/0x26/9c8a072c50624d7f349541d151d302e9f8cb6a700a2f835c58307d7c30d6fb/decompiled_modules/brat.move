module 0x269c8a072c50624d7f349541d151d302e9f8cb6a700a2f835c58307d7c30d6fb::brat {
    struct BRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAT>(arg0, 6, b"BRAT", b"SUIBRAT", b"BRAT of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brat_9781398525313_lg_2856d19bd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

