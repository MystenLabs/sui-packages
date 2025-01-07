module 0xe03c047a1c85887ed3a3c4b775d0d74c752dfce736705e5abacbbc3ddf27bf8b::july_nana_faucet_token {
    struct JULY_NANA_FAUCET_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JULY_NANA_FAUCET_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JULY_NANA_FAUCET_TOKEN>(arg0, 8, b"July-NANA Faucet", b"July-NANA Faucet Coin", b"Faucet coin published by July-NANA", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JULY_NANA_FAUCET_TOKEN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JULY_NANA_FAUCET_TOKEN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JULY_NANA_FAUCET_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JULY_NANA_FAUCET_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

