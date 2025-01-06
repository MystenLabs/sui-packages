module 0x568f655344e66bddeda33bf5d436c6a5e3311363f565b52bdebc67f7f6fb046a::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 6, b"BNB", b"Bot&Borg Ai", b"Bot & Borg AI represents an advanced fusion of two powerful technologies: autonomous cryptocurrency trading and collective artificial intelligence. In this conceptual framework, Coin Bots are integrated into a larger Borg-like AI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736156655518.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

