module 0x5f20bae836f24d1d5250582adeb856d754dff30440faed48a873bcfabf732b0a::byteccnet_coin {
    struct BYTECCNET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BYTECCNET_COIN>, arg1: 0x2::coin::Coin<BYTECCNET_COIN>) {
        0x2::coin::burn<BYTECCNET_COIN>(arg0, arg1);
    }

    fun init(arg0: BYTECCNET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTECCNET_COIN>(arg0, 6, b"byteccnet COIN", b"byteccnet COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYTECCNET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTECCNET_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BYTECCNET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BYTECCNET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

