module 0x890b1e3bba8837466cd0700228d3ede3cfcd02f702a83b67d540922c6632260::ocmt {
    struct OCMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCMT>(arg0, 8, b"OCMT", b"OnChainMetrics", b"AI-driven market intelligence for DeFi. Predictive analytics, risk management, and cross-chain liquidity mapping.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/e07cc96d-5107-457e-842b-4d8d8b909a29.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCMT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCMT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

