module 0x40b77bfc455b9e14e34c455015ff33ce707ffc79b7d5d5aeeb0bae31f8a36bcb::memo {
    struct MEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMO>(arg0, 6, b"Memo", b"Get The Memo", b"Get the Memo in the deep blue sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/80392206_0449_4108_8ea0_e0fe8e9b92fa_fa0c932024.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

