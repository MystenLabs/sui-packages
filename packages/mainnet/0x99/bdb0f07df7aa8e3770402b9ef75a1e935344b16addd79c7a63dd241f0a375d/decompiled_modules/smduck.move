module 0x99bdb0f07df7aa8e3770402b9ef75a1e935344b16addd79c7a63dd241f0a375d::smduck {
    struct SMDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMDUCK>(arg0, 6, b"SMDUCK", b"Scrooge McDuck", b"Meet Scrooge McDuck $SMDUCK, the idol of millions of people! Join the duck army and start getting rich. Be a rich duck -  buy a Scrooge McDuck!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_bb421d6fe9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

