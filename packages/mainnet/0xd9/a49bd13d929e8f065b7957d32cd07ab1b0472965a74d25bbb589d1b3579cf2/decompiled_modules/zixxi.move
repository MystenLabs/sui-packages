module 0xd9a49bd13d929e8f065b7957d32cd07ab1b0472965a74d25bbb589d1b3579cf2::zixxi {
    struct ZIXXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIXXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIXXI>(arg0, 6, b"ZIXXI", b"zixxi", b"zix", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-internal-do-not-share.hop.ag/fun/0xae7c6c5dc6fa7705bb54ea671c30b8f318db59dfef6fc16164c101028cfb53a2::tst::TST")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<ZIXXI>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<ZIXXI>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

