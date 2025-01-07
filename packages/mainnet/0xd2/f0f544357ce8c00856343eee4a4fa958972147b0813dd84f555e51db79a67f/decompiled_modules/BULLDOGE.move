module 0xd2f0f544357ce8c00856343eee4a4fa958972147b0813dd84f555e51db79a67f::BULLDOGE {
    struct BULLDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLDOGE>(arg0, 9, b"BULLDOGE", b"Bull + Doge", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Hdk3oDFxAW3Ykb2TBDgR4Gm1y5asq54hWnBeeyNiZLbs.png?size=xl&key=9ce413")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLDOGE>>(0x2::coin::mint<BULLDOGE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BULLDOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

