module 0xbfbb687378a950c45f826be44d60c6b30b822bf62a96e7c36a5e7b1d7a897f09::suiguard {
    struct SUIGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUARD>(arg0, 6, b"SUIGUARD", b"SUIGUARD (BOT)", b"SUIGUARD TELEGRAM BOT ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3951_7d8c37db41.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

