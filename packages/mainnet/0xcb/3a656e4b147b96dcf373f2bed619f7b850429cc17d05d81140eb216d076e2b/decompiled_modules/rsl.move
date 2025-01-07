module 0xcb3a656e4b147b96dcf373f2bed619f7b850429cc17d05d81140eb216d076e2b::rsl {
    struct RSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSL>(arg0, 6, b"RSL", b"Rising straight line", b"I hope all coins continue to rise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0b8c5cc7bf930e9496f86209c7e5e214_f9fc586268.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

