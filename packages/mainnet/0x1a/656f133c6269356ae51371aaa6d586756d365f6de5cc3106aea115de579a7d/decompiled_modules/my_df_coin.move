module 0x1a656f133c6269356ae51371aaa6d586756d365f6de5cc3106aea115de579a7d::my_df_coin {
    struct MY_DF_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_DF_COIN>, arg1: 0x2::coin::Coin<MY_DF_COIN>) {
        0x2::coin::burn<MY_DF_COIN>(arg0, arg1);
    }

    fun init(arg0: MY_DF_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_DF_COIN>(arg0, 9, b"MDFC", b"My DF Coin", b"A DF coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_DF_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_DF_COIN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_DF_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_DF_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

