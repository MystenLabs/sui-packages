module 0x4887fd02749ff65338a8168b3ca956a014b8b791cfd450909940e77ddd18e79f::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"Suiton Ninja by SuiAI", b"An automated agent designed to bring stories and knowledge from distant lands to the $Sui ecosystem. Powered by $SUIAI. The Ninja Clan awaits you. Agile, bold, and always on the move with Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_5_cf5d439d70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

