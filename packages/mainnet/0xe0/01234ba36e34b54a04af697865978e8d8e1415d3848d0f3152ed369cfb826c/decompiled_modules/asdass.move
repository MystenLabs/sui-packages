module 0xe001234ba36e34b54a04af697865978e8d8e1415d3848d0f3152ed369cfb826c::asdass {
    struct ASDASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASS>(arg0, 6, b"asdass", b"zxcasazz", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmb7ESDLLZmKcJyPmtHz8cegvsZRF8bUcYuWs4ySVHj2m8?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASDASS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASS>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

