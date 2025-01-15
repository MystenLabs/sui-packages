module 0xcde39f77b31b6121c6e4e58a84414e6de2abb5f5342891f361c488ec95d23a4e::busi {
    struct BUSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSI>(arg0, 6, b"BUSI", b"SuBusi", b"The blue of Sui blue's SuBusi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluecolor_56e09c66e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

