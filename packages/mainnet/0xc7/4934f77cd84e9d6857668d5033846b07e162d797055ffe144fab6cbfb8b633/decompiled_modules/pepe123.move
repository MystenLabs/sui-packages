module 0xc74934f77cd84e9d6857668d5033846b07e162d797055ffe144fab6cbfb8b633::pepe123 {
    struct PEPE123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE123>(arg0, 9, b"PEPE123", b"PEPE123", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d391b93f5f62d9c15f67142e43841acc.ipfscdn.io/ipfs/QmZMTnCNYincJTTtNvxptHGEnB36F336C544Re5Zjo2QLj")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE123>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPE123>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE123>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

