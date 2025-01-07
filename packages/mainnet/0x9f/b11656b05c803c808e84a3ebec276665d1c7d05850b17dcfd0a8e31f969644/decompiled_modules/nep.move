module 0x9fb11656b05c803c808e84a3ebec276665d1c7d05850b17dcfd0a8e31f969644::nep {
    struct NEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEP>(arg0, 6, b"NEP", b"NEPTUNUS", b"NEPTUNUS is an AI-powered trading bot offering advanced features for crypto enthusiasts. It includes instant contract audits, real-time price charts, swap functionality, and trend analysis across multiple chains (SUI, Ethereum, BSC, with Solana in testing). The bot automates buy/sell actions, scans contracts for safety, and provides alerts on the latest crypto listings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000175349_af541f19f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

