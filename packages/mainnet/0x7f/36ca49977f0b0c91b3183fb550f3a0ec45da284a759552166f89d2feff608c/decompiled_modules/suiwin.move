module 0x7f36ca49977f0b0c91b3183fb550f3a0ec45da284a759552166f89d2feff608c::suiwin {
    struct SUIWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIN>(arg0, 9, b"SuiWin", b"SuiWin Game Coin", b"This is a collection of cryptocurrency gambling games that ensure fairness and transparency, utilizing SuiNetwork for provably fair random numbers, allowing bets and results to be determined in a single transaction!no KYC!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9cabd7869d842a73a0a76586effb699cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

