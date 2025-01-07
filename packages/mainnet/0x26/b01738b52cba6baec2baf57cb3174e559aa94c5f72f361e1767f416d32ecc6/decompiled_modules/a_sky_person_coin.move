module 0x26b01738b52cba6baec2baf57cb3174e559aa94c5f72f361e1767f416d32ecc6::a_sky_person_coin {
    struct A_SKY_PERSON_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<A_SKY_PERSON_COIN>, arg1: 0x2::coin::Coin<A_SKY_PERSON_COIN>) {
        0x2::coin::burn<A_SKY_PERSON_COIN>(arg0, arg1);
    }

    fun init(arg0: A_SKY_PERSON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_SKY_PERSON_COIN>(arg0, 6, b"A_SKY_PERSON_COIN", b"A_SKY_PERSON_COIN", b"I love A_SKY_PERSON_COIN. I love blockchains.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_SKY_PERSON_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_SKY_PERSON_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<A_SKY_PERSON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<A_SKY_PERSON_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

