module 0xe8dc96790bfaf32d37167e60729a6455046b5db9169bb7b2e00e7ae1ff8b8772::breakingbad {
    struct BREAKINGBAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAKINGBAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAKINGBAD>(arg0, 6, b"BREAKINGBAD", b"BREAKING BAD", b"$Breakingbad make you reach financial freedom without breaking bad, while in crypto you just have to invest, hold and trust the process", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0160_acae7fd02e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAKINGBAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAKINGBAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

