module 0xea99c34383db90e8563755ce919eab93024cef8cc2e30fcd658d19a5547e135::COBIE {
    struct COBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBIE>(arg0, 9, b"COBIE", b"COBIE", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BWi8nNi1ahNzqu6YvEzLT9oRc9GXoeQN7Fib4Q3wpump.png?size=xl&key=52416b")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COBIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<COBIE>>(0x2::coin::mint<COBIE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COBIE>>(v2);
    }

    // decompiled from Move bytecode v6
}

