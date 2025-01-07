module 0x29d69b35032f4a5259f4d593f56d6fd5b1bce3054b91c9da3f8bcf7ba6440fe0::husky {
    struct HUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSKY>(arg0, 6, b"HUSKY", b"Husky", b"I love you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVraBKid84b4N1UqKvikvYdbYxgxCqmWv3mRYtSkTHEo9?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUSKY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSKY>>(v2, @0xacd4dfc04a74936d0048540b691ac4961c1f429a138b9fa091d26469657cd729);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

