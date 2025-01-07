module 0x36410d69e0a47f2c480a63db7b5830ca5e6bd9bc49a1147d690b3451399217f8::qwewqe {
    struct QWEWQE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWEWQE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWEWQE>(arg0, 6, b"qwewqe", b"asdasdqwe", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmb7ESDLLZmKcJyPmtHz8cegvsZRF8bUcYuWs4ySVHj2m8?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QWEWQE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWEWQE>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWEWQE>>(v1);
    }

    // decompiled from Move bytecode v6
}

