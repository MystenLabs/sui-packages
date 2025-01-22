module 0xd3d84cc251c2add1b231ae4b0023b28f1dd74f36255304d76ce94b6419a1e65d::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 9, b"DOGE", b"Department of Government Efficiency on Sui", b"DOGE DOGE DOGGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xd4c7ae4e56c25f151650b3f761077105f5af12f13f7997c5a58aba96aa1b63c8::doge::doge.png?size=xl&key=f2481f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

