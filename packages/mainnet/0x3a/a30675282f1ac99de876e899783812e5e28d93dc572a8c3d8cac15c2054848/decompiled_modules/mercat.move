module 0x3aa30675282f1ac99de876e899783812e5e28d93dc572a8c3d8cac15c2054848::mercat {
    struct MERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCAT>(arg0, 6, b"MERCAT", b"MERCAT SUI", b"Is it a fish? Is it a cat? No its a mercy, Live on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_22_57_32_83f24b971a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

