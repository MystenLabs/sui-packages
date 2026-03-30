module 0x97b8b26aaba014cca23a8c7506b2b939176e715dfaa18255e47d9d5a91ec6a65::us_national_bitcoin_reserve_before_2027_1767888370276_yes {
    struct US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276_YES>(arg0, 0, b"US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276_YES", b"US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276 YES", b"US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<US_NATIONAL_BITCOIN_RESERVE_BEFORE_2027_1767888370276_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

