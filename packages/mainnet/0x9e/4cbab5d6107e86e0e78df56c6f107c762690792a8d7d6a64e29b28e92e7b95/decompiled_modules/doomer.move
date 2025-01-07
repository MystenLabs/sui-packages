module 0x9e4cbab5d6107e86e0e78df56c6f107c762690792a8d7d6a64e29b28e92e7b95::doomer {
    struct DOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOMER>(arg0, 6, b"doomer", b"Doomer", b"This is doomer. sad doomer. Works a boring job and listens to post-punk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmNUvjfjuh4HoBLWgJKYzE63eYtS2ALYHeK6avqQ1tLskx?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOOMER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOMER>>(v2, @0x95c2bf41d7b61c00d73203dc8f465f2dc1a845a0899441415e39cd91af8e4091);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

