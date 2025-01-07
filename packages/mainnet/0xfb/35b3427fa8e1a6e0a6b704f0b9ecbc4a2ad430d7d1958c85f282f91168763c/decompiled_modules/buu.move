module 0xfb35b3427fa8e1a6e0a6b704f0b9ecbc4a2ad430d7d1958c85f282f91168763c::buu {
    struct BUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUU>(arg0, 6, b"BUU", b"BUU on SUI", b"JUST BUULIEVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/el4_1hqy_400x400_406037b150.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

