module 0xf87d058b7bf7fadef035ed910fa58a4f3e2debb38c6f07700657ab4da1d87eee::aaasui {
    struct AAASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASUI>(arg0, 6, b"AAASUI", b"aaaSUI", b"aaaaaaaaaaaaaaaaaaaSUIETaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa_b147adae0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

