module 0x94024d336c663c3acdec171f73847860e1bc2e674857911c66d12335243a37b9::sbot {
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

