module 0x89374bdc3fc4c0ba0aad55cf6a725a7d6b7b435fa942a32106b36531e9f1212d::ssb {
    struct SSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSB>(arg0, 6, b"SSB", b"Sui Street Bets", b"Sui Street Bets is an innovative community and platform inspired by the phenomenon of Wall Street Bets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SSB_Logo_43d3047187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

