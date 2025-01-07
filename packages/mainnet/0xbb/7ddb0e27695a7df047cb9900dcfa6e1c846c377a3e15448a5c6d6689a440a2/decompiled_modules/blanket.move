module 0xbb7ddb0e27695a7df047cb9900dcfa6e1c846c377a3e15448a5c6d6689a440a2::blanket {
    struct BLANKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLANKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLANKET>(arg0, 6, b"BLANKET", b"Blanket Sui dog", b"Blanket - in cold weather we need a blanket to keep warm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008715_bcc688ed45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLANKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLANKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

