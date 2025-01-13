module 0xd7f4b4b05de4883ac303dd8a334f40ddd9bc7fb87d5d5b4665e285b830c470a7::scholar {
    struct SCHOLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHOLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCHOLAR>(arg0, 6, b"SCHOLAR", b"Learn AI Scholar by SuiAI", b"An intelligence of a schoolgirl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dalle_42d949081a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCHOLAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHOLAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

