module 0xa2c3109d17f0830a95dd4fdb05cab853e7ebdf0a1eccc3de2a442e7e59de7b11::bertie {
    struct BERTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERTIE>(arg0, 6, b"BERTIE", b"Bertie Sandwich", b"I read books, which makes me better than you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017074_e8cb13d6a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

