module 0x393d40ab544ce0744ba59a1420d2259ae44c553d240655050d9622f66ef18de7::MOUSEY {
    struct MOUSEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUSEY>(arg0, 9, b"MOUSEY", b"Mousey - PNUT's Nickname", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AdsrKt5rH6H8cUZtSZEsBjmmGTHJaGrUe92Lj4PaJvna.png?size=xl&key=5d1761")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOUSEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOUSEY>>(0x2::coin::mint<MOUSEY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOUSEY>>(v2);
    }

    // decompiled from Move bytecode v6
}

