module 0x1e3c4c3bc603beb58b3e9f0e8754053940a0ad8faea3621d14c8cdf7f1a20d9a::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 9, b"FLIP", b"Flipper", b"Ready to flip the script on crypto? With $FLIP, you can ride the waves of Sui with a token that's fast, fun, and full of surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6oojEEjagTthqva8W8Bz3AriL16kWYu7iLg3gmb4bzgS.png?size=xl&key=265faa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLIP>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

