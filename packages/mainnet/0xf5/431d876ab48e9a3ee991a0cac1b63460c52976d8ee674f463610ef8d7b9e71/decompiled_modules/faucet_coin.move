module 0xf5431d876ab48e9a3ee991a0cac1b63460c52976d8ee674f463610ef8d7b9e71::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::mint<FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"Heemale Faucet", b"Heemale Faucet Coin", x"e79bb8e4bfa1e79a84e5bf83e698afe68891e4bbace79a84e9ad94e6b395", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::string::to_ascii(0x1::string::utf8(b"https://avatars.githubusercontent.com/u/57651639?s=400&u=25e8d8a5c8eed5d1408617994c5d8ea8ec0ac5c2&v=4")))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

