module 0xa4c219e4fec258ab7a8c6234930ee833820f535883d559bd6ba930fca41ed6d8::btcus {
    struct BTCUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCUS>(arg0, 6, b"BTCUS", b"BTB", b"A decentralized cryptocurrency project focused on fast transactions, community governance, and real-world utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1779087249682.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

