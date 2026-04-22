module 0xa81d9dea17e698cad3f7e0714b8d1eb666da68e2748b3407d376284c6d0e42ad::will_the_price_of_bitcoin_be_between_78000_80000_on_april_22_no {
    struct WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22_NO>(arg0, 0, b"WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22_NO", b"WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22 NO", b"WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_THE_PRICE_OF_BITCOIN_BE_BETWEEN_78000_80000_ON_APRIL_22_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

