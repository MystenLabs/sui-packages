module 0x674b06d0e9b1b7af20c421a19b06d8a9c23e74de460ba17d1d646efa83a6af7c::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 6, b"Pussy", b"PU$$Y RIOT", b"Pussy Riot is a Russian feminist protest and performance art group based in Moscow. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pussy_riot_head_wear_c6bd8c45bf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

