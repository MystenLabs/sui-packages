module 0xeaf05fb6a1a24a9e29e1df9102273669ac3811dfd25f4950a317bf15a81cf1da::ibutt {
    struct IBUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBUTT>(arg0, 6, b"IBUTT", b"I Butthole", x"57656c636f6d6520746f20746865206772616e642070616c616365206f66204942757474686f6c652120f09f92b0f09f92a82041206c75787572696f7573207265616c6d207768657265206d656d6573206d656574207765616c746821204d617276656c206174206d79206272696c6c69616e636520616e642072656c697368207468652073796d70686f6e79206f66206d792066617274732e204a6f696e206f72206265206c65667420696e2074686520647573742120f09f92a8f09f92b5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737211977971.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBUTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBUTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

