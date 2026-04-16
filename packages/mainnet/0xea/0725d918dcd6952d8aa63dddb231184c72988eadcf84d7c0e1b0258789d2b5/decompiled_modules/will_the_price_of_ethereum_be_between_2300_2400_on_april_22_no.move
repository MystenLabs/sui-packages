module 0xea0725d918dcd6952d8aa63dddb231184c72988eadcf84d7c0e1b0258789d2b5::will_the_price_of_ethereum_be_between_2300_2400_on_april_22_no {
    struct WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22_NO>(arg0, 0, b"WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22_NO", b"WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22 NO", b"WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_THE_PRICE_OF_ETHEREUM_BE_BETWEEN_2300_2400_ON_APRIL_22_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

