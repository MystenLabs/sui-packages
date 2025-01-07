module 0xbc1a2375d3cbe2cc208e80c1b8eeffccbf4bfe66206c10bdded05c1fc0d1144::suimonk {
    struct SUIMONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONK>(arg0, 6, b"SUIMONK", b"MONK FISH", b"$MONK the spooky fish from $SUI ocean comes from a deep, dark and cold ocean zone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3545_d19d9ad8a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

