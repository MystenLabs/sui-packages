module 0xbc2418eb5761953533f6b7a3471d49ec976ea94672dc508779bf90042021592b::hema {
    struct HEMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMA>(arg0, 6, b"HEMA", b"China Moo Deng", x"4368696e61204d6f6f2044656e67204f4e204d6f76652050756d700a68747470733a2f2f742e6d652f45544847656d5f63616c6c2f333838", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28828c23b2ea628d407fa5985cb837e1_63eadd8e2e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

