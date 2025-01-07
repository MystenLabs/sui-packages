module 0x4e8ddc8d020dfaee78acaaac5ab38e8299202819d0809acbe1dd017e2e3dcca0::popgoat {
    struct POPGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPGOAT>(arg0, 9, b"POPGOAT", b"Goatseus Poppimus", x"426861612120f09f9090f09f92a520476f61747365757320506f7070696d757320706f7070696e67206f6e205355492c20626c6f636b20627920626c6f636b21204268616121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DtWz93pDUZe5cYqBFmZjXq1wzZqZPygCeox5d3ajpump.png?size=xl&key=28efe7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPGOAT>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPGOAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

