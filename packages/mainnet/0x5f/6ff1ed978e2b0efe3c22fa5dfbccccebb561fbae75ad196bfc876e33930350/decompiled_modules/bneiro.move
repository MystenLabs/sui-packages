module 0x5f6ff1ed978e2b0efe3c22fa5dfbccccebb561fbae75ad196bfc876e33930350::bneiro {
    struct BNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNEIRO>(arg0, 6, b"BNEIRO", b"BOOK OF NEIRO", x"424f4f4b204f46204e4549524f0a0a54454c454752414d204f4e4c5920534f4349414c530a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bookofneiro_337d5cf21b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

