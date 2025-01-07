module 0xada01905d3ed687b18d4a0a80e4919177b735efed1c74f3566ad45df7f038f9d::nyk {
    struct NYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYK>(arg0, 6, b"NYK", b"NEWYORK", b"The best city in the world !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fob_79a250b8fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYK>>(v1);
    }

    // decompiled from Move bytecode v6
}

