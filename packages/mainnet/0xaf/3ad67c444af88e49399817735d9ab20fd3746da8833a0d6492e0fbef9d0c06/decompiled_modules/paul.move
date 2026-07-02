module 0xaf3ad67c444af88e49399817735d9ab20fd3746da8833a0d6492e0fbef9d0c06::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PAUL>(arg0, 9, 0x1::string::utf8(b"PAUL"), 0x1::string::utf8(b"Paul strategy"), 0x1::string::utf8(b"Stable"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/3GPQL3HZNnFhN_F7l5Aa-X1VOtAKwIsg9zuWk8R81v4"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PAUL>>(0x2::coin_registry::finalize<PAUL>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<PAUL>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<PAUL>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

