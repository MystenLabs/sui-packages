module 0xbcff3cb161e866bc078caa0879f7fcc2aabf6ca7251f58f92499cac75ffbb06b::mgc {
    struct MGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGC>(arg0, 6, b"MGC", b"MG Coin", b"MG Coin is a futuristic cryptocurrency featured in Squid Game 2, symbolizing power and greed in high-stakes scenarios. It serves as the digital currency for bets, rewards, and control, reflecting the dark allure of technology and survival.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735532258532.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

