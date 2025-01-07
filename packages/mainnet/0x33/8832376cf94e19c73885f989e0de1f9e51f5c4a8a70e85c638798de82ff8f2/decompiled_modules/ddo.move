module 0x338832376cf94e19c73885f989e0de1f9e51f5c4a8a70e85c638798de82ff8f2::ddo {
    struct DDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDO>(arg0, 9, b"DDO", b"DODO", b"DODO is a DeFi protocoldecentralized finance (DeFi) protocol and on-chain liquidity provider whose unique proactive market maker (PMM) algorithm aims to offer better liquidity and price stability than automated market makers (AMM).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/adefe353-ffc3-43ca-a6f1-d98fe74d2c4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

