module 0x89a9e11a59725c1fe1c1a331869badc7c84daa8982a7e105045e668f0b566801::lly {
    struct LLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LLY>(arg0, 6, 0x1::string::utf8(b"LLYs"), 0x1::string::utf8(b"Eli Lilly Surge Stock"), 0x1::string::utf8(b"Synthetic Eli Lilly exposure through Aftermath perpetuals. No ownership of the underlying asset. Funding and fees affect value."), 0x1::string::utf8(b"https://surgefun.xyz/assets/stocks/LLYs.png"), arg1);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::stock::stage_currency<LLY>(v1, v0, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, arg1);
    }

    // decompiled from Move bytecode v7
}

