module 0xa03b1b7d984dcdbde33b081e11013e07737f9a3f5270f2a0746e633f73cb213::infinity_money {
    struct INFINITY_MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINITY_MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775597353848-27a584f6fc9bf04ec640cfcce7cdf368.gif";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775597353848-27a584f6fc9bf04ec640cfcce7cdf368.gif"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<INFINITY_MONEY>(arg0, 9, b"Infinity Money", b"Sui infinity Money", b"Your Best Way Is here", v1, arg1);
        let v4 = v2;
        if (100000000000000000 > 0) {
            0x2::coin::mint_and_transfer<INFINITY_MONEY>(&mut v4, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINITY_MONEY>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INFINITY_MONEY>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

