module 0x7bc83fb1d2de1869fd96d866cd2b9e7abbeaf42d6ab594e4b92892e03ef414dc::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTA>(arg0, 6, b"SANTA", b"Sui Santa", b"Christmas came early to Sui! $SANTA is here to celebrate Sui smashing ATHs daily, bringing festive vibes and gifts to the degen community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_137ecdb5fe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

