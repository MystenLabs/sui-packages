module 0xb68ab867673c1c06debfcbff046180d636c7d5a93f200c704d9b3f9fb421917f::bururu {
    struct BURURU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURURU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURURU>(arg0, 9, b"BURURU", b"Bururu", b"Welcome to Igloo Livin' With Bururu! Here, Bururu the yeti shares his cozy, snow-filled life in the friendliest way possible. Join in for warm stories, ice-cool tips, and a whole lot of wholesome vibes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AYb3x3nTJ9c6K5wopQa58jiWcYbvMriDRra3Q3b8pump.png?size=lg&key=25d5b7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BURURU>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURURU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURURU>>(v1);
    }

    // decompiled from Move bytecode v6
}

