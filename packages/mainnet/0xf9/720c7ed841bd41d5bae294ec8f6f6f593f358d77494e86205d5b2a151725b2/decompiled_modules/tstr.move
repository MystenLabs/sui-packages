module 0xf9720c7ed841bd41d5bae294ec8f6f6f593f358d77494e86205d5b2a151725b2::tstr {
    struct TSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTR>(arg0, 6, b"TSTR", b"TST", b"Just Testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test_icon_a371b84e12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

