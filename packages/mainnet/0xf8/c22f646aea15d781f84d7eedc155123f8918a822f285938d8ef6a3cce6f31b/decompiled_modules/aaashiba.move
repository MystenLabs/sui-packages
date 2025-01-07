module 0xf8c22f646aea15d781f84d7eedc155123f8918a822f285938d8ef6a3cce6f31b::aaashiba {
    struct AAASHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASHIBA>(arg0, 6, b"AAASHIBA", b"aaashibaaa", b"aaaaaaaaaashibaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_5ed85e0458.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

