module 0x4156c61f6a5b10f54f1dab77bdcc9836fa69ade4797aedeeae9232e22c312c71::DNUT {
    struct DNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNUT>(arg0, 9, b"DNUT", b"Dnut the Psycho Squirrel", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AdwDgNiuvxMBCoJVTXeNrjhTFh1sF7bAaCxUVAn4rGWz.png?size=xl&key=c933fd")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DNUT>>(0x2::coin::mint<DNUT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DNUT>>(v2);
    }

    // decompiled from Move bytecode v6
}

