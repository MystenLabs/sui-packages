module 0xb298efb7e0a7a622952d0073c0b9bb54ea2eb56a92cc7656dcb21234645c5f1d::sbot {
    struct SBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOT>(arg0, 6, b"Sbot", b"SuiBridgeBot", b"SuiBridgebot is a cross-chain bridge built for Sui blockchain, enabling seamless asset transfers between major blockchains like Ethereum, Solana, BSC, and more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sbot_main_logo_3b829a12e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

