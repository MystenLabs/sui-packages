module 0xe48e25f70cc78ef5de3580657a3ebbabb9917a635526a9479ed4d5256c54b608::jonkler {
    struct JONKLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JONKLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JONKLER>(arg0, 6, b"JONKLER", b"WHY SO SERIOUS?", b"WHY SO SERIOUS? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_3_0553c1f91d_77312ddfc2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JONKLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JONKLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

