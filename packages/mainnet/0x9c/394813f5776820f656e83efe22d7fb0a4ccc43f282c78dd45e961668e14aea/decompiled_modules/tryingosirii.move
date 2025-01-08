module 0x9c394813f5776820f656e83efe22d7fb0a4ccc43f282c78dd45e961668e14aea::tryingosirii {
    struct TRYINGOSIRII has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYINGOSIRII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYINGOSIRII>(arg0, 9, b"TRYINGOSIRII", b"TRYINGOSIRI", b"sd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYINGOSIRII>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYINGOSIRII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYINGOSIRII>>(v1);
    }

    // decompiled from Move bytecode v6
}

