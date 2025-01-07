module 0x1308bb3be045dd29baa21fa235571e6cfcc22a7ea3a4bf5f4bac6896a95a230::praxis525m {
    struct PRAXIS525M has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRAXIS525M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRAXIS525M>(arg0, 6, b"Praxis525M", b"Praxis", x"507261786973204275696c64696e6720746865206669727374206e6574776f726b207374617465200a0a243532354d20696e2066696e616e63696e6720666f7220407072617869736e6174696f6e20746f206275696c6420746865206e65787420677265617420636974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6897_f99419f186.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRAXIS525M>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRAXIS525M>>(v1);
    }

    // decompiled from Move bytecode v6
}

