module 0x4c526af066be6127ff01da928c0521cfd76e3937dd509d8409e9eabc09b73a86::GATO {
    struct GATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATO>(arg0, 9, b"GATO", b"El GATO", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/G7BJzg55Afx6Tn6J9CJfA444jMf6QJbVjgQAevNTpump.png?size=xl&key=01b6bf")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GATO>>(0x2::coin::mint<GATO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GATO>>(v2);
    }

    // decompiled from Move bytecode v6
}

