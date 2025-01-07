module 0xe1159f3183dc1b915257aae3274a8004d0bd4316f75df6755804c33b19c750c6::monkeys {
    struct MONKEYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEYS>(arg0, 6, b"MONKEYS", b"Monkeys", b"The Most Degenerate Monkeys on the most Degenerate Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MONKEY_2a60c7f6c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

