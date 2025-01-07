module 0xa4c021bac511b1803ba4acd98282a8dabfb31fcaff49007aab806736316082a::popgoat {
    struct POPGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPGOAT>(arg0, 6, b"POPGOAT", b"Goatseus Poppimus", x"426861612120f09f9090f09f92a520476f61747365757320506f7070696d757320706f7070696e67206f6e20536f6c616e612c20626c6f636b20627920626c6f636b21204268616121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/DtWz93pDUZe5cYqBFmZjXq1wzZqZPygCeox5d3ajpump.png?size=lg&key=30ff2c"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPGOAT>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPGOAT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPGOAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

