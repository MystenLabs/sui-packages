module 0xa5813a3f83f8dbe7dc91c1dbb7af88afb27f9354fe161a760b79b2558b5dccef::ustd {
    struct USTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USTD>(arg0, 6, b"USTD", b"Teter", b"To won dollah u degeneraz, the new meta is here, and is ours, together united to make history.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_fdfe27e33c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

