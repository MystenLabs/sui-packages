module 0xf3873b0386bf1170ee126d760d5a2d941e2f8ce1a3448d0e9fa1935e72adfc6d::skype {
    struct SKYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYPE>(arg0, 6, b"Skype", b"SKYPE ON SUI", b"Let's wake up our memories of the old days with skype, texting and calling with friends when we were childrens, carefree young life and the only thing we were interested in was, when we will be on skype and play a game together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250123_222728_575_b015d1b4b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

