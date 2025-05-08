module 0xf50d5c55d41692ee3f52eebdabb7bb0eef0f2ebf64f7ba5579e21241f503ce7f::titcoin {
    struct TITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITCOIN>(arg0, 9, b"TITCOIN", b"titcoin", b"$titcoin the breast technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FtUEW73K6vEYHfbkfpdBZfWpxgQar2HipGdbutEhpump.png?size=xl&key=cfda6a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TITCOIN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITCOIN>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

