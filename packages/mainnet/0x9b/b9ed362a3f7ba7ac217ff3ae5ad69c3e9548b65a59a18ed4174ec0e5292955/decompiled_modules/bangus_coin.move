module 0x9bb9ed362a3f7ba7ac217ff3ae5ad69c3e9548b65a59a18ed4174ec0e5292955::bangus_coin {
    struct BANGUS_COIN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"BNGS", b"Bangus Coin", b"Official Coin of Web3Pangasinan", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: BANGUS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<BANGUS_COIN>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANGUS_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BANGUS_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BANGUS_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

