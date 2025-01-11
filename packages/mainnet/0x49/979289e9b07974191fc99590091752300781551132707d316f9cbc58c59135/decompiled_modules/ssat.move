module 0x49979289e9b07974191fc99590091752300781551132707d316f9cbc58c59135::ssat {
    struct SSAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SSAT>(arg0, 6, b"SSAT", b"SuiSocialAIr by SuiAI", b"SuiSocialAIr ($SSAT) is the native token for the Sui-based AI trading project. It powers trading, social features, and AI processes, facilitating value exchange and community growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/100_3c9734ad3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

