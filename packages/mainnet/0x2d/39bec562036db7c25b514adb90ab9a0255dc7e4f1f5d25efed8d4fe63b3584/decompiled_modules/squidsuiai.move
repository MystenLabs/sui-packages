module 0x2d39bec562036db7c25b514adb90ab9a0255dc7e4f1f5d25efed8d4fe63b3584::squidsuiai {
    struct SQUIDSUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDSUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDSUIAI>(arg0, 6, b"SQUIDSUIAI", b"SquidSuiAI", b"In a crypto world where only the bold thrive, Squid Sui AI emergedan AI-powered token with a witty, mischievous squid, SquidMaster, designed to help you win big. As the Sui blockchain grew, Squid Sui AI needed more players.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736265562483_301d0aa754.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDSUIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDSUIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

