module 0xa7c55b1872ee7d7f80fe646b80c18dd2f9c7bcb0a34506440ae522f8b3c05e38::dollars {
    struct DOLLARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLARS>(arg0, 6, b"DOLLARS", b"3-up Moon Coin", x"4641510a0a31292041726520746865736520646f6c6c6172733f210a0a4e6f2e20546865792061726520332d7570204d6f6f6e20436f696e732e204261736963616c6c79206a75737420617320676f6f6420617320646f6c6c6172732074686f756768e280a60a0a3229205768792061726520746865726520332d75703f0a0a426563617573652033206c6976657320697320626574746572207468616e20312e204974206665656c7320676f6f6420746f2067657420332d75702e0a0a3329205768792067657420312d7570207768656e20796f752063616e2067657420332d75703f0a0a54686174e280997320776861742049e280996d20736179696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733040680753.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLLARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

