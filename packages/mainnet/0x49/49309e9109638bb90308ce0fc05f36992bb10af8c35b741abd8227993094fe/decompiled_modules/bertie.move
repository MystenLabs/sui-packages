module 0x4949309e9109638bb90308ce0fc05f36992bb10af8c35b741abd8227993094fe::bertie {
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

