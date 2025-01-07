module 0xbc67c4363e3cb90bac8f119fcb1010830cc8244956192b329bd823a26614f404::sfund {
    struct SFUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFUND>(arg0, 6, b"Sfund", b"Suifund", b"Suifund is now available on the sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000150589_2733edca90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFUND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFUND>>(v1);
    }

    // decompiled from Move bytecode v6
}

