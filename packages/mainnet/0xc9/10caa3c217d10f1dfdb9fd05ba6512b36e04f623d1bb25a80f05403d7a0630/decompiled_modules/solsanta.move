module 0xc910caa3c217d10f1dfdb9fd05ba6512b36e04f623d1bb25a80f05403d7a0630::solsanta {
    struct SOLSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLSANTA>(arg0, 9, b"SOLSANTA", b"Solana Santa", b"Solana Santa is a meme token that brings the holiday spirit to the Solana ecosystem! With Santa as its mascot, this token is designed to spread joy, gifts, and fortune to the crypto community. Join the magical journey with Solana Santa and experience the joy of giving with every transaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8TFv79J2Kd2Cp2tboiDZ1GnmaTBkN3JNJEnjQavSpump.png?size=lg&key=3779ca")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOLSANTA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLSANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLSANTA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

