module 0x9adeaffb2e4f8477054d651f6a95c4c92e0730f44e2758e835674648c5804720::aaapopcat {
    struct AAAPOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPOPCAT>(arg0, 6, b"AAAPOPCAT", b"aaaPopCat", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaapopcat_8c90c22fe7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

