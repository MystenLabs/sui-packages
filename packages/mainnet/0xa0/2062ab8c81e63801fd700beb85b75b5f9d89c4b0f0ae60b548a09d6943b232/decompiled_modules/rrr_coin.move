module 0xa02062ab8c81e63801fd700beb85b75b5f9d89c4b0f0ae60b548a09d6943b232::rrr_coin {
    struct RRR_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR_COIN>(arg0, 9, b"RRR", b"rrr", b"rrr", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RRR_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

