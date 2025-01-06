module 0xebdb45ceb1a86e5228f6f8b412664bf8d3c9347b89193ed919a7b59e691cf9dd::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", b"LOFI ai by SuiAI", b"A YETI FROZEN IN TIME, THAWED OUT AND PREPARED TO LEAD THE CRYPTO WORLD TO AN ICEY LIFESTYLE. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3612_45fa553507.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOFI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

