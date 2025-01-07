module 0xe19ae70efc908de1703db38be70d54e6199fcbbd9c2d65b36123e2ba1239ab00::suiloplopy {
    struct SUILOPLOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOPLOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOPLOPY>(arg0, 6, b"Suiloplopy", b"Loopopy", b"loolooplooploopyloopyloopy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3087_342555b769.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOPLOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILOPLOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

