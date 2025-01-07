module 0x746cb557e5d57dd7820b7845d5ab5c7b0034ff066768e3156495b7eb7e047416::sansui {
    struct SANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANSUI>(arg0, 6, b"SANSUI", b"SANTA on SUI", b"Santa Live On MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fk_FJD_Bq_400x400_060f287957.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

