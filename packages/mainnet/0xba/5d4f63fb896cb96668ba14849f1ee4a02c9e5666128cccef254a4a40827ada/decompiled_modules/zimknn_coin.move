module 0xba5d4f63fb896cb96668ba14849f1ee4a02c9e5666128cccef254a4a40827ada::zimknn_coin {
    struct ZIMKNN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZIMKNN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZIMKNN_COIN>>(0x2::coin::mint<ZIMKNN_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZIMKNN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ZIMKNN_COIN>(arg0, 8, b"ZIMKNN", b"ZIMKNN Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIMKNN_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ZIMKNN_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIMKNN_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

