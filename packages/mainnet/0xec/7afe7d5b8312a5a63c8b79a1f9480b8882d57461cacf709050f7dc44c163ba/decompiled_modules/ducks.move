module 0xec7afe7d5b8312a5a63c8b79a1f9480b8882d57461cacf709050f7dc44c163ba::ducks {
    struct DUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKS>(arg0, 6, b"DUCKS", b"SUIDUCKIUS", b"Launch DEX > 24h", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/go_155816be1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

