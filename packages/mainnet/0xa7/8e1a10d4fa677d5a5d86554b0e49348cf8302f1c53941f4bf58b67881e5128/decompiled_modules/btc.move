module 0xa78e1a10d4fa677d5a5d86554b0e49348cf8302f1c53941f4bf58b67881e5128::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 9, b"BTC", b"Bitcoin", b"First crypto ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/btc.png/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v2, @0x94fbcf49867fd909e6b2ecf2802c4b2bba7c9b2d50a13abbb75dbae0216db82a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

