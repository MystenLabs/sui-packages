module 0xbae448b2e4012a773661c588fe4965ab15d075a6c90cf8223ca98b8a83e1144a::strumph {
    struct STRUMPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMPH>(arg0, 6, b"STRUMPH", b"SuiTrumph", b"This is Trumph token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_8e6cc697e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRUMPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

