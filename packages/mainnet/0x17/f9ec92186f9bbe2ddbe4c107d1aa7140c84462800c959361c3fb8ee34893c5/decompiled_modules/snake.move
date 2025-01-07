module 0x17f9ec92186f9bbe2ddbe4c107d1aa7140c84462800c959361c3fb8ee34893c5::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"snake", x"536c697468657220746f20746865204d6f6f6e210a537373732d75636365737321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_dd49eebb64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

