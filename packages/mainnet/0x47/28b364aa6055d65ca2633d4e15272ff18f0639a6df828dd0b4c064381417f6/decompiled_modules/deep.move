module 0x4728b364aa6055d65ca2633d4e15272ff18f0639a6df828dd0b4c064381417f6::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"DeepBook", b"The premier decentralized liquidity layer for builders, traders, and the broader DeFi community, exclusively on @SuiNetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_Resmi_2024_10_14_11_42_17_cb5ba50866.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

