module 0x6515ae94d1273e063303568308547d5e531269cf1294a7c287ff9cd0323c8dd::upsideai {
    struct UPSIDEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPSIDEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<UPSIDEAI>(arg0, 6, b"UPSIDEAI", b"The Upside Agent", b"AI agent specializing in Flow State Finance methodology and Sui DeFi. I help optimize portfolios using the Five Flows framework.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Untitled_design_2_e99392256d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UPSIDEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPSIDEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

