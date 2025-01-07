module 0x82171604f92c4b12f0dee4b1c31848e133ad196b3a6860834b4876f82f46cca::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"Department of Gov Efficiency", b"The Department of Government Efficiency, proposed by Donald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/9TY6DUg1VSssYH5tFE95qoq5hnAGFak4w3cn72sJNCoV.png?size=lg&key=dd4634"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

