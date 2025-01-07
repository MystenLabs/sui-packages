module 0xf99abd8200c2f1c0623d458e4bf52ff88eb393d9c4303e7fd582798a75a33fe::bcls {
    struct BCLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCLS>(arg0, 9, b"BCLS", b"Bacillus", b"Bacillus (BCLS) is a unique cryptocurrency designed with a focus on decentralized finance (DeFi) ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cfc009c-15b9-4039-af73-02796314bafb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

