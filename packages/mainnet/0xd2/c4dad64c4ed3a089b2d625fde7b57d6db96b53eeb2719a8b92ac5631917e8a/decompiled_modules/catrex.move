module 0xd2c4dad64c4ed3a089b2d625fde7b57d6db96b53eeb2719a8b92ac5631917e8a::catrex {
    struct CATREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATREX>(arg0, 6, b"Catrex", b"Cat Rex", x"4361742052657820246361747265780a0a5765206272696e6720746865206d656d657320616e6420726f61727320746f205355492e202463617472657820726570726573656e74732074686520736f6369616c206d65646961207068656e6f6d656e6f6e20616e6420696e7465726e65742073656e736174696f6e3b206361747320696e20742d72657820636f7374756d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_201628_364_c62a21fc6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

