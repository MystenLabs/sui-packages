module 0xd95b85b96c14a629979e8b1cbd1006ca5718e6c9a6fef464acb625995f5c0347::yearnethereumyield {
    struct YEARNETHEREUMYIELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEARNETHEREUMYIELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEARNETHEREUMYIELD>(arg0, 6, b"YearnEthereumYield", b"YEY", b"The Yearn Ethereum Yield aims to provide financial services traditionally provided by central financial institutions, But it needs to be made more transparent and economically available through the power of blockchain and decentralised finance. History has long shown that banks, governments and traditional financial systems are vulnerable to economic irregularities and corruption.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/46460c38125694c37095c3ede6db87a_cdfcc29a78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEARNETHEREUMYIELD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEARNETHEREUMYIELD>>(v1);
    }

    // decompiled from Move bytecode v6
}

