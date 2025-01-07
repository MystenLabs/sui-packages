module 0x3f738c7611c99b4a22ed4ccdc53b2bf440e3750050643037d25423471e697b1::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 8, b"TROLL", b"Sui Troll Face", b"Trollface or Troll Face is a rage comic meme image of a character wearing a mischievous smile, used to symbolise internet trolls and trolling. It is one of the oldest and most widely known rage comic faces", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J1sBe44.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TROLL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

