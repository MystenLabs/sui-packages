module 0xf0c07897c509bf3f6de39fff65c64584cb352e37d0d11885e2ca0b615858ea07::hopfun {
    struct HOPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPFUN>(arg0, 6, b"HOPFUN", b"HOP FUN on SUI", b"PHASE 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopfun_4d79f684fb.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

