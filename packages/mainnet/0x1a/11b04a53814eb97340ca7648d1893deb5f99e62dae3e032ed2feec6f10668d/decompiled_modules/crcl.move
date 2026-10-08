module 0x1a11b04a53814eb97340ca7648d1893deb5f99e62dae3e032ed2feec6f10668d::crcl {
    struct CRCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CRCL>(arg0, 6, 0x1::string::utf8(b"CRCLs"), 0x1::string::utf8(b"Circle Surge Stock"), 0x1::string::utf8(b"Synthetic Circle exposure through Aftermath perpetuals. No ownership of the underlying asset. Funding and fees affect value."), 0x1::string::utf8(b"https://surgefun.xyz/assets/stocks/CRCLs.png"), arg1);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::stock::stage_currency<CRCL>(v1, v0, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, arg1);
    }

    // decompiled from Move bytecode v7
}

