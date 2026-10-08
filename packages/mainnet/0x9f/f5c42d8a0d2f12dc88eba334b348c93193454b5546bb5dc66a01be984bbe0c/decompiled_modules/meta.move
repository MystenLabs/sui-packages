module 0x9ff5c42d8a0d2f12dc88eba334b348c93193454b5546bb5dc66a01be984bbe0c::meta {
    struct META has drop {
        dummy_field: bool,
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<META>(arg0, 6, 0x1::string::utf8(b"METAs"), 0x1::string::utf8(b"Meta Surge Stock"), 0x1::string::utf8(b"Synthetic Meta exposure through Aftermath perpetuals. No ownership of the underlying asset. Funding and fees affect value."), 0x1::string::utf8(b"https://surgefun.xyz/assets/stocks/METAs.png"), arg1);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::stock::stage_currency<META>(v1, v0, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, arg1);
    }

    // decompiled from Move bytecode v7
}

