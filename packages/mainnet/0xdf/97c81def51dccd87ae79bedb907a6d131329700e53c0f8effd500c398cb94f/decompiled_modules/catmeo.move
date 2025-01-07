module 0xdf97c81def51dccd87ae79bedb907a6d131329700e53c0f8effd500c398cb94f::catmeo {
    struct CATMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMEO>(arg0, 6, b"CATMEO", b"Catmeo", b"Catmeo is a ranger cat with meo friends that stands out for digital currencies, not only that catmeo is our idol cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037416_7ef1e49eaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

