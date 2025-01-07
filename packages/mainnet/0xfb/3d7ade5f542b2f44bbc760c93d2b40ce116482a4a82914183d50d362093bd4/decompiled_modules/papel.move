module 0xfb3d7ade5f542b2f44bbc760c93d2b40ce116482a4a82914183d50d362093bd4::papel {
    struct PAPEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPEL>(arg0, 6, b"PAPEL", b"PAPEL", b"Everything in this world is governed by balance. There's what you stand to gain and what you stand to lose. And when you think you have nothing to lose, you are overconfident.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPBHzwiev7JaB7ZpxsuwwVujPhZb6dX4JbqSPYYHcCbdP?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAPEL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPEL>>(v2, @0xc1cbfcb671ea8d2fe94abba65c99adfe6ed085c50c232848e04c44b4cd7bc9c5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

