module 0x9fc7ced9052e8a4ec293468c6214edde704af22f251dabab0028d45ccec7e12c::suidev {
    struct SUIDEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEV>(arg0, 6, b"SUIDEV", b"SuicidedevS", x"5468657920666967757265206d6520612064656164206d6f746865726675636b65720a4275742049276d206a7573742061206d6f746865726675636b657220746861742077616e6e612062652064656164", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQ5oCqGSAm4V84A5dX31PLkn3Yfvye6ZW8xEN8nLfhEuY?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDEV>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEV>>(v2, @0x84b09f8f1e641230d08f0b841eac8e2ae5f45de121bf02bc024df8ec5bfc1c42);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

