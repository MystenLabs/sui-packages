module 0x68bc3da58ce4b28e56ac3e7cd07e5afb003aa2229b7710c79e3acfa357a8ea8a::mrsui {
    struct MRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRSUI>(arg0, 6, b"MRSUI", b"MR SUI", b"KING OF SEA MR SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x0e1df46686c3cc6630c6f526b22ee83c834ea755a0548415b965142c293b5fbd_mrsui_mrsui_3a2e7547cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

