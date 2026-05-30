module 0x9573348a5653ebe5d0c9cf53fa699d7c014441353a3cc5d51de74f0ec03f093e::coin_factory {
    struct LAUNCHER_COIN has drop {
        dummy_field: bool,
    }

    public entry fun deploy_and_mint(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LAUNCHER_COIN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<LAUNCHER_COIN>(v0, arg0, arg1, arg2, arg3, 0x1::option::none<0x2::url::Url>(), arg4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAUNCHER_COIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNCHER_COIN>>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

