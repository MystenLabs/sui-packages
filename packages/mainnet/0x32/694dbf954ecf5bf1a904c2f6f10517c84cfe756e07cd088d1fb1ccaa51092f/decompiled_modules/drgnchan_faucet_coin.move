module 0x32694dbf954ecf5bf1a904c2f6f10517c84cfe756e07cd088d1fb1ccaa51092f::drgnchan_faucet_coin {
    struct DRGNCHAN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRGNCHAN_FAUCET_COIN>, arg1: 0x2::coin::Coin<DRGNCHAN_FAUCET_COIN>) {
        0x2::coin::burn<DRGNCHAN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: DRGNCHAN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRGNCHAN_FAUCET_COIN>(arg0, 9, b"DGC", b"DRGNCHAN_FAUCET_COIN", b"drgnchan Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/40224023?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRGNCHAN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DRGNCHAN_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRGNCHAN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRGNCHAN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

