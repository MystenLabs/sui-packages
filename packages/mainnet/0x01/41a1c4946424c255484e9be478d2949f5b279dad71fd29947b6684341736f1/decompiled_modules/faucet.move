module 0x141a1c4946424c255484e9be478d2949f5b279dad71fd29947b6684341736f1::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 8, b"ZHH4314", b"ZHH4314 Faucet", b"ZHH", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

