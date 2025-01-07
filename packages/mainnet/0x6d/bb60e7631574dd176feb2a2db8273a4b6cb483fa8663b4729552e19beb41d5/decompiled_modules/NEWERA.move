module 0x6dbb60e7631574dd176feb2a2db8273a4b6cb483fa8663b4729552e19beb41d5::NEWERA {
    struct NEWERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWERA>(arg0, 9, b"NEWERA", b"New Era : The AI Revolution", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7DRmRvxK9G6a5uMyFdfa7UaQC6dRAZz1dgioy9Htpump.png?size=xl&key=3f16b8")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWERA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEWERA>>(0x2::coin::mint<NEWERA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEWERA>>(v2);
    }

    // decompiled from Move bytecode v6
}

