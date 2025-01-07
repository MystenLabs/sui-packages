module 0x2e776ca3393e9871d2453c844ddf0e97f58fc220267e62b255d187e622422555::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"AAA", b"sdfsdfsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPmV25s7wSckFwHKLdZz5xJZMtbq9f1uqf4UUrPvzUxJP?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<A>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v2, @0x4a641ca021bcb534d4a7f83a9bec24c8c5b0399d0a1e4fb43d1b69f4ffa6a7af);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A>>(v1);
    }

    // decompiled from Move bytecode v6
}

