module 0xd309fb657f81c6ddde2e6455a4aa16d621d57c3b04a4357d269a9eabc909db23::ripleys_sui {
    struct RIPLEYS_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPLEYS_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPLEYS_SUI>(arg0, 9, b"rSui", b"Ripleys Staked Sui", b"Ripleys Staked Sui is a liquid staking protocol on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/ripleys.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPLEYS_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPLEYS_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

