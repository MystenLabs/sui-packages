module 0xd5cd7b4aca3e8b08cd3c2d476e3724f9ed2b2a46ccd6ef48aabef93179d146a1::dicker {
    struct DICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKER>(arg0, 6, b"DICKER", b"Christmas Dicker", b"Ho ho ho fucking ho! There's no Santa in crypto, only Christmas $DICKER. On his pepe reindeer, he's already fucking giving out presents. Who was this year a good Hold'em will get real magic. Put the fucking milk and cookies away, $DICKER only needs your mood for pump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_de883d0699.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

