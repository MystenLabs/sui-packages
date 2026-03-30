module 0x7927240fc7c8af1d2de3b1db0dd4bc56a49219ee21596921a788cebccb2d9538::will_stablecoins_hit_dollar500b_before_2027_1767951992467_no {
    struct WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467_NO>(arg0, 0, b"WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467_NO", b"WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467 NO", b"WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_STABLECOINS_HIT_DOLLAR500B_BEFORE_2027_1767951992467_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

