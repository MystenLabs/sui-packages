module 0x757da9eb40a4f3beb76f43fca01ed116758f8eb5a305b18f9020b07dd3697849::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"kai", x"4b616920746865206e6f726d69657320747572746c652c20627574206765742062756c6c7920636f7a20686164206469636b686561640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_01_53_56_33407f10fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

