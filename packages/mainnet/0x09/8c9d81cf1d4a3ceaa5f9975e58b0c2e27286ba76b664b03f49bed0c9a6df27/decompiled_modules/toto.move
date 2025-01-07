module 0x98c9d81cf1d4a3ceaa5f9975e58b0c2e27286ba76b664b03f49bed0c9a6df27::toto {
    struct TOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTO>(arg0, 6, b"TOTO", b"totochan", b"Totochan looking for her Little sister memechan. Because papachan getting worried about his daughter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmfRDYiMvvib4KJR5s3NkM5wFeJCSyNqeiWHVgHGiDzBKA?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOTO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO>>(v2, @0xacd4dfc04a74936d0048540b691ac4961c1f429a138b9fa091d26469657cd729);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

