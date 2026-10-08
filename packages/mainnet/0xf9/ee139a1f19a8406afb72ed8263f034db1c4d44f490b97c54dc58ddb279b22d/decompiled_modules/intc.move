module 0xf9ee139a1f19a8406afb72ed8263f034db1c4d44f490b97c54dc58ddb279b22d::intc {
    struct INTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<INTC>(arg0, 6, 0x1::string::utf8(b"INTCs"), 0x1::string::utf8(b"Intel Surge Stock"), 0x1::string::utf8(b"Synthetic Intel exposure through Aftermath perpetuals. No ownership of the underlying asset. Funding and fees affect value."), 0x1::string::utf8(b"https://surgefun.xyz/assets/stocks/INTCs.png"), arg1);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::stock::stage_currency<INTC>(v1, v0, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, arg1);
    }

    // decompiled from Move bytecode v7
}

