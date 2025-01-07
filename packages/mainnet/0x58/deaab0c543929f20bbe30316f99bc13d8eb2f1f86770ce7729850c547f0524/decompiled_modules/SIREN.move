module 0x58deaab0c543929f20bbe30316f99bc13d8eb2f1f86770ce7729850c547f0524::SIREN {
    struct SIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIREN>(arg0, 9, b"Siren", b"Siren's Embrace", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/081/062/101/large/thiago-lehmann-mermaid-small.jpg?1729259154")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIREN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIREN>>(0x2::coin::mint<SIREN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SIREN>>(v2);
    }

    // decompiled from Move bytecode v6
}

