module 0xefe2d3106e05144be7b5be57811690cfcdad63e5786ea8bc3c5d2cf44fef0f7e::x01000010 {
    struct X01000010 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X01000010, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X01000010>(arg0, 6, b"X01000010", b"01000010", b"This is a digital meme coin managed by the community itself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_13_105036_748ed8d1f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X01000010>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X01000010>>(v1);
    }

    // decompiled from Move bytecode v6
}

