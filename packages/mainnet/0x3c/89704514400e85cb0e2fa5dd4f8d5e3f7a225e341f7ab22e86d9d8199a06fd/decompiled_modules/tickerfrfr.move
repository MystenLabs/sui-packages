module 0x3c89704514400e85cb0e2fa5dd4f8d5e3f7a225e341f7ab22e86d9d8199a06fd::tickerfrfr {
    struct TICKERFRFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKERFRFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKERFRFR>(arg0, 6, b"tickerfrfr", b"tokenfr", b"2$ market cap token fr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmXvhs8oAS6A1KWDP9xfu9UDtxbUs1Tb7nbXHLfBTwFAdz?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICKERFRFR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKERFRFR>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKERFRFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

