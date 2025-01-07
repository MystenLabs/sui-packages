module 0xcd82dbd3aa89114c97450904e2e12bb9abc493daea4e7630baa2a93ddf719bd1::goats {
    struct GOATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATS>(arg0, 9, b"GOATS", b"The GOATS", b"GOATS is a decentralized crypto project aimed at empowering its community through innovative DeFi solutions and unique tokenomics. GOATS enables users to take control of their financial future in a robust ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/042f1180-7981-4575-877c-bfe7d7445ae5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

