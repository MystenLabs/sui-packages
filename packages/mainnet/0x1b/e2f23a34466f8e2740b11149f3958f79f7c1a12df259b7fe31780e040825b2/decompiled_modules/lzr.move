module 0x1be2f23a34466f8e2740b11149f3958f79f7c1a12df259b7fe31780e040825b2::lzr {
    struct LZR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LZR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZR>(arg0, 6, b"LZR", b"Lazarus Coin", x"4c617a6172757320436f696e2028244c5a5229e28093204120737465616c74682063727970746f63757272656e6379206372656174656420627920746865206c6567656e64617279206861636b65722067726f75702c206265796f6e6420636f6e74726f6c206f72207375727665696c6c616e63652e20476f7665726e6d656e747320666561722069742c2062616e6b732068756e742069742c2062757420616c6c20617474656d707473206661696c2e2020244c5a52206265636f6d657320612073796d626f6c206f662066696e616e6369616c2066726565646f6d207768657265206d6f6e65792062656c6f6e677320746f20746865", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/073f91d9-dbc3-4554-aa00-78148cad8cda.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

