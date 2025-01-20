module 0xafde6d709697691515ffec998193485391cfa03f650222c624bd70f933f6e4f0::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 9, b"SATOSHI", b"SATOSHI Meme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/HR8XXXMDrNFBsYrVXu3rioxHe1uZGrocrZGofKcMpump.png?size=lg&key=fcda8a"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SATOSHI>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

