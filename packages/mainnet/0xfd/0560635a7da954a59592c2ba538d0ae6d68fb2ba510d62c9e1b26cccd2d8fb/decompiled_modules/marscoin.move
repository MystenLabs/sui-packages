module 0xfd0560635a7da954a59592c2ba538d0ae6d68fb2ba510d62c9e1b26cccd2d8fb::marscoin {
    struct MARSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSCOIN>(arg0, 6, b"MARSCOIN", b"MARS", b"$MARS , The humanity's big leap. Why go to moon when you can go to mars? To the mars and beyond!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_Ko_Dn_Ydj_400x400_c21621018c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

