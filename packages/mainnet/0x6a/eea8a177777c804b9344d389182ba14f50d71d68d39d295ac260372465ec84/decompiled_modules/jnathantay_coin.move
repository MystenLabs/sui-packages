module 0x6aeea8a177777c804b9344d389182ba14f50d71d68d39d295ac260372465ec84::jnathantay_coin {
    struct JNATHANTAY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JNATHANTAY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JNATHANTAY_COIN>>(0x2::coin::mint<JNATHANTAY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JNATHANTAY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<JNATHANTAY_COIN>(arg0, 8, b"JNATHANTAY", b"JNATHANTAY Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNATHANTAY_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<JNATHANTAY_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JNATHANTAY_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

