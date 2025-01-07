module 0x6841885a258c8c757a15662161d51797e5c6b5ddf67754b96613f2da7cd71600::ferrorsui {
    struct FERRORSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERRORSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERRORSUI>(arg0, 6, b"FERRORSUI", b"Fatal Error SUI", b"Fatal Error SUI is a chaotic memecoin inspired by critical system failures and the volatile nature of the Sui blockchain. Just like a fatal error in code, this coin is unpredictable and disruptive, with wild price swings and sudden crashes. Its a risky yet thrilling ride for those who dare to embrace the digital chaos, where every transaction could lead to a fortuneor a complete meltdown!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fatal_Error_SUI_3b000dfa02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERRORSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERRORSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

