module 0x72e95849479f18e67d8ebebb9a704fbdaf42f060ec11d25855018e0b30f87391::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"cat", x"54686520676f6c64656e2043617420686173206120636f6f6c20617070656172616e636520616e64206973746865206669727374206d656d6520696e2074686520616e696d616c2043617420776f726c640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000370_b5dc87a75c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

