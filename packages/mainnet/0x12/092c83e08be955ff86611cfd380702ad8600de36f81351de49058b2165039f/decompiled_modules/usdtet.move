module 0x12092c83e08be955ff86611cfd380702ad8600de36f81351de49058b2165039f::usdtet {
    struct USDTET has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTET>(arg0, 9, b"USDTET", b"Wrapped USDT BSC", b"USD Peggy BSC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmYjwqz1xoBSYZ27rMhQuZBYg1PDUGJBRWkJm4uGgukhPx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDTET>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDTET>>(v1);
    }

    // decompiled from Move bytecode v6
}

