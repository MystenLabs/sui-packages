module 0xdb979a55997acab6b35ce6d4bf198b6736bd428d1d4bbfa03a9248310388aee4::some_coin {
    struct SOME_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOME_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOME_COIN>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"SOME_COIN", b"COIN", b"No dewscprtion needed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOME_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOME_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

