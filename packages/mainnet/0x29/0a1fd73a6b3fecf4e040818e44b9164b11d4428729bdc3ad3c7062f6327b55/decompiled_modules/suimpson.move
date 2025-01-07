module 0x290a1fd73a6b3fecf4e040818e44b9164b11d4428729bdc3ad3c7062f6327b55::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPSON>(arg0, 6, b"SUIMPSON", b"BART", b"Bart's most prominent and popular character traits are his mischievousness, rebelliousness and disrespect for authority. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bimpson_96c1d1e266.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

