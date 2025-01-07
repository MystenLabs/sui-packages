module 0x424b5042ee862ab396506f986624e9f22c318034c00c654fdcbdef5fc11cbb01::atm {
    struct ATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ATM>(arg0, 6, b"ATM", b"ATM SIGN", b"SuiEmoji Atm Sign", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/atm.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

