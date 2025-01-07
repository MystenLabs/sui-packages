module 0xb25864dde9a1058df14c5e1d6dae83f1b92bc7bc125aab6ba54bfea5c3a17a79::apewar {
    struct APEWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEWAR>(arg0, 6, b"APEWAR", b"SuiApe War", b"Every ape strives for domination to be the best!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_B2lcz0_Q_400x400_5f7dd454cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

