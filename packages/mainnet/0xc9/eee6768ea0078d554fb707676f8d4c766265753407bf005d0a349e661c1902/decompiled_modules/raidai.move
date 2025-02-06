module 0xc9eee6768ea0078d554fb707676f8d4c766265753407bf005d0a349e661c1902::raidai {
    struct RAIDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAIDAI>(arg0, 6, b"RAIDAI", b"RAIDAI by SuiAI", b"RAIDAI on the SUI Network is a project that leverages the capabilities of the Sui blockchain for decentralized AI agent operations", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_20_ad7aec0bc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAIDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

