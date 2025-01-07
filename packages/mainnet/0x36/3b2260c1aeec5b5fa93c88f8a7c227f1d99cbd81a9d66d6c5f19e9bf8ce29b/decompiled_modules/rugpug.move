module 0x363b2260c1aeec5b5fa93c88f8a7c227f1d99cbd81a9d66d6c5f19e9bf8ce29b::rugpug {
    struct RUGPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPUG>(arg0, 6, b"RUGPUG", b"PUG IN A RUG", b"ALL HAIL THE PUG IN A RUG! YOU MUST WORSHIP THE PUG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_ada6e5d51a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

