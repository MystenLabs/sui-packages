module 0x30e0f1bc60623c62818123a14304b318bb05b139284406f8dc01fbe52027c864::drama {
    struct DRAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAMA>(arg0, 6, b"drama", b"suidrama", b"be the first one to buy to dump on others! welcome to the sui experience", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmcLGR3R7VPnQxHmauaepZJgSvEfWhPQ6K6cGNHehmvheG?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRAMA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAMA>>(v2, @0x9b6e8b336874135b698c92e00a1541752faf6498ab1da5b682df3506068a0aae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

