module 0xb03c9e9979a048d805182fb5fbfbdf7bc2be60348f22144643232dd2aef66d58::byte {
    struct BYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTE>(arg0, 6, b"BYTE", b"Byte", b"We are embarking on an exciting new chapter for $BYTE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ggaga_5a0236de54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

