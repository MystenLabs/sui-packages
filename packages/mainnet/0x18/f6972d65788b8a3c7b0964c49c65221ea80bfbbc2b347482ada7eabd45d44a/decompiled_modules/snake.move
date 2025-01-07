module 0x18f6972d65788b8a3c7b0964c49c65221ea80bfbbc2b347482ada7eabd45d44a::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"snake", x"4c6f766520736e616b65732c2070726f7465637420736e616b65732c20737570706f727420706561636520616e646f70706f73652076696f6c656e63650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000367_6c1eb86d40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

