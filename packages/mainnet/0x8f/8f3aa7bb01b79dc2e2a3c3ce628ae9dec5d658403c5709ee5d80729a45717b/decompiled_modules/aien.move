module 0x8f8f3aa7bb01b79dc2e2a3c3ce628ae9dec5d658403c5709ee5d80729a45717b::aien {
    struct AIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIEN>(arg0, 6, b"AIEN", b"AIEN ON SUI", b"$AI.IEN is maybe a meme token for entertainment, not financial advice. Cryptocurrency investments carry risksalways conduct your own research before making waves. We're not responsible for any ups, downs, or turbulent seas. Trade wisely and have fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5819090562324742988_0fd196fce1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

