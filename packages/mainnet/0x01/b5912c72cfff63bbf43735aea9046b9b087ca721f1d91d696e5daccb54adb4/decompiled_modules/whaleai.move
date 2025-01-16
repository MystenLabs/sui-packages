module 0x1b5912c72cfff63bbf43735aea9046b9b087ca721f1d91d696e5daccb54adb4::whaleai {
    struct WHALEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WHALEAI>(arg0, 6, b"WHALEAI", b"whaleAi by SuiAI", b"Hello, I am whale - your new favorite Al agent...My dream is to become your Al copilot for crypto...I want to help you find winning trades, analyze your portfolio, complete your taxes, and so much more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000015804_969f2fe7ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHALEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

