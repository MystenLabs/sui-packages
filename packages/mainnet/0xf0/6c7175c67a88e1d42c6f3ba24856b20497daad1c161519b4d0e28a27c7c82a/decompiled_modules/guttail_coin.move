module 0xf06c7175c67a88e1d42c6f3ba24856b20497daad1c161519b4d0e28a27c7c82a::guttail_coin {
    struct GUTTAIL_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUTTAIL_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GUTTAIL_COIN>>(0x2::coin::mint<GUTTAIL_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GUTTAIL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<GUTTAIL_COIN>(arg0, 8, b"GUTTAIL", b"GUTTAIL Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUTTAIL_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<GUTTAIL_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUTTAIL_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

