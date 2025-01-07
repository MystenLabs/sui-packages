module 0x9da83c8cf9da2ce005d364c24e97b0ac992590d843cbe4323fb3f964b0ccccce::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAI>(arg0, 6, b"CATAI", b"AICAT", b"TRUTH TERMINAL CAT. FIRST CAT TERMINAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asqqcxzzx_7e7827ab80.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

