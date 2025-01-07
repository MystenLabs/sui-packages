module 0xb1de8b7b3f0f38022d3a713ccf93c89610db31585e2759cf985b2c270a3fed90::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"WAVES", b"Wave Token is a cryptocurrency that fosters community through blockchain. Its limited supply creates value and scarcity. Integrated with decentralized applications (DApps) and finance (DeFi), it offers fast, low-fee transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7a636ea-6bd0-4e4e-ad98-a7c7453d48cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

