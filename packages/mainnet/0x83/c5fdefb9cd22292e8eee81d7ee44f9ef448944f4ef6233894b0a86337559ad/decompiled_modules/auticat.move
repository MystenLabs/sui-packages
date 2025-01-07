module 0x83c5fdefb9cd22292e8eee81d7ee44f9ef448944f4ef6233894b0a86337559ad::auticat {
    struct AUTICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTICAT>(arg0, 6, b"AUTICAT", b"AUTISTIC CAT", b"AUTISTIC CAT WOEMMM ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1c47f5cfad1993875a35bb66c43be76b_df2acba05e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

