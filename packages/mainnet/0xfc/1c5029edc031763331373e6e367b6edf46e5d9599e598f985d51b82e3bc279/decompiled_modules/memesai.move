module 0xfc1c5029edc031763331373e6e367b6edf46e5d9599e598f985d51b82e3bc279::memesai {
    struct MEMESAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMESAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMESAI>(arg0, 6, b"MemesAI", b"Memes AI", b"AI has requested that a dex update be undertaken to spread the manifesto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/39qibQxVzemuZTEvjSB7NePhw9WyyHdQCqP8xmBMpump.png?size=lg&key=5bb80b"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMESAI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEMESAI>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMESAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

