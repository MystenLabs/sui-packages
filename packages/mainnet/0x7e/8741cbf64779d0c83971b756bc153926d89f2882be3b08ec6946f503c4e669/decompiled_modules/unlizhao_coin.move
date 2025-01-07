module 0x7e8741cbf64779d0c83971b756bc153926d89f2882be3b08ec6946f503c4e669::unlizhao_coin {
    struct UNLIZHAO_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UNLIZHAO_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNLIZHAO_COIN>>(0x2::coin::mint<UNLIZHAO_COIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<UNLIZHAO_COIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNLIZHAO_COIN>>(arg0, arg1);
    }

    fun init(arg0: UNLIZHAO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<UNLIZHAO_COIN>(arg0, 8, b"UNLIZHAO", b"UNLIZHAO Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNLIZHAO_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<UNLIZHAO_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNLIZHAO_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

