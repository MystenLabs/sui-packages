module 0x8e7b9eee707c9f95d039157cdf5776062928145176ceca79a5b5478fe16e3be5::pacsui {
    struct PACSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACSUI>(arg0, 6, b"PACSUI", b"PAC", b"Read the America PAC website to understand why I support @realDonaldTrump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6113_d124c9e0d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

