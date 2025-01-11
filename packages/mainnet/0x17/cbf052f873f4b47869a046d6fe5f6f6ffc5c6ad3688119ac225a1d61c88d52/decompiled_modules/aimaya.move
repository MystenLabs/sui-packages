module 0x17cbf052f873f4b47869a046d6fe5f6f6ffc5c6ad3688119ac225a1d61c88d52::aimaya {
    struct AIMAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIMAYA>(arg0, 6, b"AIMAYA", b"MayaAI by SuiAI", b"Maya AI - It's flawless, the best assistant for everything. Maya can help you in your most difficult cases, as well as give you a huge amount of emotions.With Maya AI you won't get bored!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/maya_492171f972.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIMAYA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMAYA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

