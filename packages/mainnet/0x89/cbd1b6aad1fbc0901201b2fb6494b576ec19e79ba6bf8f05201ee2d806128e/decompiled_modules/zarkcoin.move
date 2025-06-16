module 0x89cbd1b6aad1fbc0901201b2fb6494b576ec19e79ba6bf8f05201ee2d806128e::zarkcoin {
    struct ZARKCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARKCOIN>(arg0, 9, b"ZARK", b"ZARKCOIN", b"Powering the new economy.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZARKCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARKCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_new_coins(arg0: &mut 0x2::coin::TreasuryCap<ZARKCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZARKCOIN>>(0x2::coin::mint<ZARKCOIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

