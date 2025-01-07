module 0xc36209dae42272d3c54708b3d4dc052366530bba1f3be71495fa9e24e31a366a::eymeria_coin {
    struct EYMERIA_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYMERIA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYMERIA_COIN>(arg0, 6, b"Eymeria-cyper", b"emeria", b"Eymeria_token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYMERIA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYMERIA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<EYMERIA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EYMERIA_COIN>>(0x2::coin::mint<EYMERIA_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

