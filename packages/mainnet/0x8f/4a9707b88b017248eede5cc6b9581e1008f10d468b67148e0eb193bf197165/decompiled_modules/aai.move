module 0x8f4a9707b88b017248eede5cc6b9581e1008f10d468b67148e0eb193bf197165::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"Ailien AI", x"48692074686572652045617274686c696e677321202845617274687320696e6861626974616e7473292c2049276d2041696c69656e2c20796f757220667269656e646c79206578747261746572726573747269616c206e65696768626f722066726f6d20746865206d6f6f6e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ailien_811dd6d244.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

