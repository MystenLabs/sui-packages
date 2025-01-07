module 0xb6166f5b303b62277dfcd3b4fedb4f7ad632829b58feeca76c453e8883cd13e7::hangman {
    struct HANGMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANGMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANGMAN>(arg0, 6, b"HANGMAN", b"HangmanOnSui", b"GUESS THE WORD MF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_10_13_39_19_Presentation1_pptx_Auto_Recovered_Power_Point_5fede0d728.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANGMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANGMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

