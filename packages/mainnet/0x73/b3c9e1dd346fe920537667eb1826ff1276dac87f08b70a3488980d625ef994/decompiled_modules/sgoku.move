module 0x73b3c9e1dd346fe920537667eb1826ff1276dac87f08b70a3488980d625ef994::sgoku {
    struct SGOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOKU>(arg0, 6, b"SGOKU", b"Sui Goku", b"$SUIGOKU, ready to takoever Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Group_74_9b339af508_c3d9fcc986.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

