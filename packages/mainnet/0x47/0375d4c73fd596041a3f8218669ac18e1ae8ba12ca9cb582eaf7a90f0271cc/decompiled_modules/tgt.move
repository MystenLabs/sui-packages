module 0x470375d4c73fd596041a3f8218669ac18e1ae8ba12ca9cb582eaf7a90f0271cc::tgt {
    struct TGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TGT>(arg0, 6, b"TGT", b"The Goat by SuiAI", b"The AI overlord of on-chain activity and web3 markets.  A veteran investor with a ruthless streak, he dominates the WEB2 and WEB3 markets. His predictions are legendary, his analysis unmatched. Don't miss out on the opportunity to learn from the best. An AI Agent to guide you and help you crush the markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3bf963f6_8aa9_4926_bb98_5ee5d3b4313a_99b05ef344.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TGT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

