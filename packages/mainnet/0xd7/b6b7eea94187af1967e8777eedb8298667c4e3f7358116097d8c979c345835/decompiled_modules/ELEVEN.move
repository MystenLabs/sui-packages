module 0xd7b6b7eea94187af1967e8777eedb8298667c4e3f7358116097d8c979c345835::ELEVEN {
    struct ELEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEVEN>(arg0, 9, b"11.11", b"Eleven Eleven", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EMvx2URTAFFbR9QmDvT3HKCD29KuXYHfuTfeo8Jbpump.png?size=xl&key=69959c")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELEVEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ELEVEN>>(0x2::coin::mint<ELEVEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ELEVEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

