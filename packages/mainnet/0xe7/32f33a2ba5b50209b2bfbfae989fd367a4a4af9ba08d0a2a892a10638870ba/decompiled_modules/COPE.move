module 0xe732f33a2ba5b50209b2bfbfae989fd367a4a4af9ba08d0a2a892a10638870ba::COPE {
    struct COPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPE>(arg0, 9, b"COPE", b"Cult of Pepe", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4J4W2tdq8gLLEdrq62HqCAbpPAci8SSQdSVvy6uLpump.png?size=xl&key=bc9a1b")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<COPE>>(0x2::coin::mint<COPE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COPE>>(v2);
    }

    // decompiled from Move bytecode v6
}

