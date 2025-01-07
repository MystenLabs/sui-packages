module 0x7974d340ed83de2506150987cf23067af89cea3c3b14536c6a110b0446e7c05e::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 9, b"DODO", b"Dodo", b"DODO is a DeFi protocoldecentralized finance (DeFi) protocol and on-chain liquidity provider whose unique proactive market maker (PMM) algorithm aims to offer better liquidity and price stability than automated market makers (AMM).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9932e497-d058-4da2-918e-def0c2a6f343.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

