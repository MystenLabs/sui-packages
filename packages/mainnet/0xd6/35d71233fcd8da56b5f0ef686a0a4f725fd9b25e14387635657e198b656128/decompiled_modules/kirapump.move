module 0xd635d71233fcd8da56b5f0ef686a0a4f725fd9b25e14387635657e198b656128::kirapump {
    struct KIRAPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRAPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRAPUMP>(arg0, 6, b"KIRAPUMP", b"PUMPFUN FILLER", x"427965f09fa4abf09fa78ff09f8fbbe2808de29982efb88f427965f09f928a0a0ac2b73a2ac2a8e0bcba20e299b1e29caee299b120e0bcbbc2a82a3ac2b7e0bc89e280a7e2828acb9af09f95afefb88ff09f96a4e29d80e0bc89e280a7e2828acb9a2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmcYQALcQ1ZemAfy1GHGZMCBWvXHZNKZyx1CkA6pefuRkS?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIRAPUMP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRAPUMP>>(v2, @0x8a46d19a5cea3854f67d85e0449c8f9567ea09d48d9c276c3b851fa7e1fd5571);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRAPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

