module 0x6f484a812a0cc14f95ba25d8e3163c952524813120fe045d57bf74fa3595a491::killem {
    struct KILLEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLEM>(arg0, 6, b"KILLEM", b"Killem coin", b"Ooh KillEm is a meme character that's all about being super relaxed and not caring much about anything. His whole vibe is lowkey  meaning he's calm, casual, and doesn't make a big deal about stuff.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049549_1c7fedb429.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

