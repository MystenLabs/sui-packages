module 0xdb918502a8cfaf2b9b595c953d7e4432573889301a6660b66b8237f3141b1c7e::SYNTHIA {
    struct SYNTHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNTHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYNTHIA>(arg0, 9, b"Synthia", b"Synthia Robot", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8pDajezgfVP6yTAVAgLkosTE4PKCQyc9mpHdPiqvpump.png?size=xl&key=ff756c")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYNTHIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SYNTHIA>>(0x2::coin::mint<SYNTHIA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SYNTHIA>>(v2);
    }

    // decompiled from Move bytecode v6
}

