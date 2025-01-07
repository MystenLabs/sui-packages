module 0xa5814f7f8360d87668738a0b95663abadcef03dbd4a2d82d89b78ccf4e0ffac5::airdrops {
    struct AIRDROPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDROPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDROPS>(arg0, 6, b"AIRDROPS", b"Airdrops", b"Airdrops is a deflationary token. Weekly airdrop winners are AI-selected and team-verified.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727294100615_9b7b2aa8c2514a00d34509f495e2dbfb_6395640822.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDROPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRDROPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

