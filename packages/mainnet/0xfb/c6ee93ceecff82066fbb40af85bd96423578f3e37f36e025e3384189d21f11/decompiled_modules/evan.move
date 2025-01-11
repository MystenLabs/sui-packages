module 0xfbc6ee93ceecff82066fbb40af85bd96423578f3e37f36e025e3384189d21f11::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EVAN>(arg0, 6, b"EVAN", b"EvanaIA by SuiAI", b"$EvanaIA embodies the spirit of Sui's co-founder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/eva6060_bad6ab6bd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

