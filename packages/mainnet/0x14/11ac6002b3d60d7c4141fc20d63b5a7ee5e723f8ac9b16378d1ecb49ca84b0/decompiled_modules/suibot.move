module 0x1411ac6002b3d60d7c4141fc20d63b5a7ee5e723f8ac9b16378d1ecb49ca84b0::suibot {
    struct SUIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOT>(arg0, 9, b"SuiBot", b"SuiBridgeBot", b"SuiBridgebot is a cross-chain bridge built for Sui blockchain, enabling seamless asset transfers between major blockchains like Ethereum, Solana, BSC, and more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fsbot_main_logo_3b829a12e5.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBOT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOT>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

