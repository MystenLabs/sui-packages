module 0x9d28d3224b4e01b12197c9e2522d47e8bf8fa32b16745de1173fd80f660c7549::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 9, b"SUIX", b"SUIXION", b"SiuXion is a trading-oriented token on the Sui network, designed for active use in decentralized exchanges, yield farming, and liquidity management through the Sui Wave Trading platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdb903cc-1d76-4de3-9984-22934499d38c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

