module 0x89e6754439ffcb8fa3253921b5628a2bbf970f429e08b0fe563d7922e35aee95::MWAH {
    struct MWAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWAH>(arg0, 9, b"mwah", b"Cat Kiss", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AbBanMS7cFvLZUGKP2jEzLXxxAE2XfTE3q9EL6DQpump.png?size=xl&key=0b09aa")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MWAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MWAH>>(0x2::coin::mint<MWAH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MWAH>>(v2);
    }

    // decompiled from Move bytecode v6
}

