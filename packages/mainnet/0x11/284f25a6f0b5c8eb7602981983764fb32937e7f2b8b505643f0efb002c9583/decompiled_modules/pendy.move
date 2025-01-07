module 0x11284f25a6f0b5c8eb7602981983764fb32937e7f2b8b505643f0efb002c9583::pendy {
    struct PENDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENDY>(arg0, 6, b"PENDY", b"PENDY ON SUI", b"hi! i'm pendy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ppp_26923d4087.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

