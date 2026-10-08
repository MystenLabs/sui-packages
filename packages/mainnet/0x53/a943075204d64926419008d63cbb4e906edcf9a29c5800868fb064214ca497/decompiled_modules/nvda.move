module 0x53a943075204d64926419008d63cbb4e906edcf9a29c5800868fb064214ca497::nvda {
    struct NVDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NVDA>(arg0, 6, 0x1::string::utf8(b"NVDAs"), 0x1::string::utf8(b"NVIDIA Surge Stock"), 0x1::string::utf8(b"Synthetic NVIDIA exposure through Aftermath perpetuals. No shareholder rights. Funding and fees affect value."), 0x1::string::utf8(b"https://surgefun.xyz/assets/NVIDIAs"), arg1);
        0xfce4ced86ce526e9612b5a2248a91d2708c2f7a1e2effa08730647360f39b22f::stock::stage_currency<NVDA>(v1, v0, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, @0xe311ecfa097633b292d4ae390a0f47e6e7f29fc3ff46b168fbaa6eadedc74e6d, arg1);
    }

    // decompiled from Move bytecode v7
}

