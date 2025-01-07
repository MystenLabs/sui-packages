module 0x808eae9e08f1117620e43eb8e0d8c06544839e1baec23879d7ede905681150c3::tomsui {
    struct TOMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMSUI>(arg0, 6, b"TOMSUI", b"TOM", b"A classic story of 60 years, Tom and Jerry has accompanied our childhood. You are not just holding a token, but a whole childhood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007544_50c22e3b2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

