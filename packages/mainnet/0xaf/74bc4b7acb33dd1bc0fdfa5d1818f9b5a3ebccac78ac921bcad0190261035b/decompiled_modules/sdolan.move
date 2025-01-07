module 0xaf74bc4b7acb33dd1bc0fdfa5d1818f9b5a3ebccac78ac921bcad0190261035b::sdolan {
    struct SDOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOLAN>(arg0, 6, b"SDOLAN", b"SUI DOLAN", b"SDolan is an MS Paint web comic series, featuring a variety of poorly drawn Disney cartoon characters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3942_6d486d151c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

