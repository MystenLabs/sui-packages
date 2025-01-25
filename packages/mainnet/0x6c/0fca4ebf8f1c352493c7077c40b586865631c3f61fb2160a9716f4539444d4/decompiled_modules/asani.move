module 0x6c0fca4ebf8f1c352493c7077c40b586865631c3f61fb2160a9716f4539444d4::asani {
    struct ASANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASANI>(arg0, 6, b"ASANI", b"Asani AI", b"Asani : AI Crypto Copilot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029367_4cd491b22e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

