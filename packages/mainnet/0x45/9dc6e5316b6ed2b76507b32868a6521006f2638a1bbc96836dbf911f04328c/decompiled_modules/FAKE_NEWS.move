module 0x459dc6e5316b6ed2b76507b32868a6521006f2638a1bbc96836dbf911f04328c::FAKE_NEWS {
    struct FAKE_NEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_NEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_NEWS>(arg0, 9, b"FAKENEWS", b"FAKE NEWS", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/E3dHUYWs849uxxyfntV63Gw8eaQWqJG79hiJPG8vbvCP.png?size=xl&key=82447d")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE_NEWS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FAKE_NEWS>>(0x2::coin::mint<FAKE_NEWS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FAKE_NEWS>>(v2);
    }

    // decompiled from Move bytecode v6
}

