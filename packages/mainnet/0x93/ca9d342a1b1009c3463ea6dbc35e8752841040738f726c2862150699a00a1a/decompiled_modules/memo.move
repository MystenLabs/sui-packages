module 0x93ca9d342a1b1009c3463ea6dbc35e8752841040738f726c2862150699a00a1a::memo {
    struct MEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMO>(arg0, 6, b"Memo", b"Get The Memo", b"Get the Memo in the blue sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/80392206_0449_4108_8ea0_e0fe8e9b92fa_5ef981ea8b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

