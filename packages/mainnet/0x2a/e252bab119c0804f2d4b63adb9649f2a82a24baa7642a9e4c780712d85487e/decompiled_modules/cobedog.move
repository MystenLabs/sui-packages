module 0x2ae252bab119c0804f2d4b63adb9649f2a82a24baa7642a9e4c780712d85487e::cobedog {
    struct COBEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBEDOG>(arg0, 6, b"COBEDOG", b"COINBASE DOG", b"Just married man's dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_a_2024_10_10_a_a_a_a_a_1_02_41_046b18f345.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

