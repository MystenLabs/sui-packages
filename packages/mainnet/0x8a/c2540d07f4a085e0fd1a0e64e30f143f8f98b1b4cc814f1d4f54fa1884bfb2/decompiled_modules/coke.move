module 0x8ac2540d07f4a085e0fd1a0e64e30f143f8f98b1b4cc814f1d4f54fa1884bfb2::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKE>(arg0, 6, b"COKE", b"Coke Bear", b"The Bear Loves Coke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cokebearrrrxd_d734e81fee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

