module 0x2fc9e5517d08cf2a1cfb2411d09fe418382433fe25147673a299ac3a9b8c569::shuning0312_faucet {
    struct SHUNING0312_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHUNING0312_FAUCET>, arg1: 0x2::coin::Coin<SHUNING0312_FAUCET>) {
        burn(arg0, arg1);
    }

    fun init(arg0: SHUNING0312_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUNING0312_FAUCET>(arg0, 8, b"SHUNING0312_FAUCET", b"SHUNING0312_FAUCET", b"this is my_coin_faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUNING0312_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHUNING0312_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHUNING0312_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHUNING0312_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

