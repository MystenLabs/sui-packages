module 0x72dd044c42edf05a822032a8b885c202df671754ac946386c1ffaa43132fdc36::suiplup {
    struct SUIPLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLUP>(arg0, 6, b"SUIPLUP", b"PLUP ON SUI", b"The most cute water pokemon is now on $SUI is SUIPLUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3544_ecdcd72157.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

