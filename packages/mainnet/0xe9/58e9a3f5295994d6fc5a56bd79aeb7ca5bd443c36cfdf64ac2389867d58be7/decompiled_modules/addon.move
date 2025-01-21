module 0xe958e9a3f5295994d6fc5a56bd79aeb7ca5bd443c36cfdf64ac2389867d58be7::addon {
    struct ADDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADDON>(arg0, 6, b"ADDON", b"AddOn AI by SuiAI", b"Monetize your Ai Agents / Socials and Earn Passive Income. Deploy Ai Advertisement Agents. Access Multiple Ai Tools. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/B0rbl10s_400x400_c34e371d2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADDON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

