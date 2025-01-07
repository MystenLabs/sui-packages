module 0x1fc4d978a1ac5b2590f019b1d751425e91ea0d821767600cabdbaf3d7e92fb78::perilla {
    struct PERILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERILLA>(arg0, 6, b"PERILLA", b"Peperilla", b"The Mighty Perilla arrived, knee before him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/462552921_1464511257578542_5976691500573757127_n_20f98c0bdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

