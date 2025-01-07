module 0xe74f6284fc7d1e49a47c21b125d4f0d972d83e12eae4f3bb5c4ee237afe6f8a9::suibabypopdeng {
    struct SUIBABYPOPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABYPOPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABYPOPDENG>(arg0, 6, b"SUIBABYPOPDENG", b"BABY POPDENG", x"4261627920706f702064656e67207375690a0a54673a2068747470733a2f2f742e6d652f506f7044656e675375690a57656273697465203a2068747470733a2f2f706f7064656e677375692e66756e2f0a58203a2068747470733a2f2f782e636f6d2f506f7044656e67537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3497_f62df61ce7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABYPOPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBABYPOPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

