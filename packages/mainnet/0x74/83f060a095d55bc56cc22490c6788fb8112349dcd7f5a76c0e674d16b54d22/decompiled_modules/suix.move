module 0x7483f060a095d55bc56cc22490c6788fb8112349dcd7f5a76c0e674d16b54d22::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 9, b"SUIX", b"SuiX", b"SuiX (SUIX) is a versatile token on the Sui blockchain, enabling seamless transactions, smart contracts, and staking rewards. SUIX drives liquidity and innovation in DeFi, NFTs, and gaming applications within the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0d6feab-17b7-42c9-814e-9ceb9dbb1064.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

