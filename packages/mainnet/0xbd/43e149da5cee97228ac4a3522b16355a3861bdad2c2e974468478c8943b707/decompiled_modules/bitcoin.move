module 0xbd43e149da5cee97228ac4a3522b16355a3861bdad2c2e974468478c8943b707::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BITCOIN>(arg0, 6, b"BITCOIN", b"Bitcoin-games by SuiAI", b"new bitcoin that will revolutionize the web with games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bitcoin_game_7bc8a6fd84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BITCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

