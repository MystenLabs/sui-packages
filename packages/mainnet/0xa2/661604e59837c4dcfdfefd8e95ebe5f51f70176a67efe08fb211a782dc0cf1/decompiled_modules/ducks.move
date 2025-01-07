module 0xa2661604e59837c4dcfdfefd8e95ebe5f51f70176a67efe08fb211a782dc0cf1::ducks {
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

