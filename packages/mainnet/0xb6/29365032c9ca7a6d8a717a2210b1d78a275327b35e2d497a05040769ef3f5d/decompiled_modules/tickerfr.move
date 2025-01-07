module 0xb629365032c9ca7a6d8a717a2210b1d78a275327b35e2d497a05040769ef3f5d::tickerfr {
    struct TICKERFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKERFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKERFR>(arg0, 6, b"tickerfr", b"hehehehehe", b"haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQq6rjAyWzZHGLA56xAxyXfu7XR7wPEy1DD4XaskK7imF?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICKERFR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKERFR>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKERFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

