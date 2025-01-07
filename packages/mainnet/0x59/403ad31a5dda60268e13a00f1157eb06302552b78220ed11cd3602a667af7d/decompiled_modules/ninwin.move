module 0x59403ad31a5dda60268e13a00f1157eb06302552b78220ed11cd3602a667af7d::ninwin {
    struct NINWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINWIN>(arg0, 6, b"NINWIN", b"nintedowns sui", x"436f6d62696e696e67204e696e74656e646f0a776974682057696e646f7773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nintedowns_807faabe4b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

