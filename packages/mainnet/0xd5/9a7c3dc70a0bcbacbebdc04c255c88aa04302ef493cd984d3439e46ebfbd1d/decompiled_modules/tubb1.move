module 0xd59a7c3dc70a0bcbacbebdc04c255c88aa04302ef493cd984d3439e46ebfbd1d::tubb1 {
    struct TUBB1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUBB1, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 624 || 0x2::tx_context::epoch(arg1) == 625, 1);
        let (v0, v1) = 0x2::coin::create_currency<TUBB1>(arg0, 9, b"TUBBI", b"TUBBI", b"TUBBI is a revolutionary meme-powered token designed to unite the gaming and crypto communities in a fun and engaging way. As the first playable character in MemeArena, TUBBI empowers users to participate in thrilling battles, stake rewards, and influence gameplay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreieayo7pa5kha2xbac2anuk6mym7ardvxhwefoa7hlazdannvlql54.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUBB1>(&mut v2, 1000000000000000000, @0x5a9ab2e7b6b47c494c1f98357cc232cffcc6fb6d239f9fcafdce01b19bf35bae, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUBB1>>(v2, @0x5a9ab2e7b6b47c494c1f98357cc232cffcc6fb6d239f9fcafdce01b19bf35bae);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUBB1>>(v1);
    }

    // decompiled from Move bytecode v6
}

