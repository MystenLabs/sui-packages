module 0xade4a6e70ceef78f40d28c1f7b8e9e0f244b3c1a1cfc47e14d511be6c484888e::patrick {
    struct PATRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATRICK>(arg0, 6, b"PTRK", b"PATRICK", x"e298af2041726520796f752072656164792c206b6964733f20e29894e29894e298942068747470733a2f2f742e6d65203c62723e200a207c7c2068747470733a2f2f782e636f6d2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GV_6KPlasAAjAbp.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PATRICK>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

