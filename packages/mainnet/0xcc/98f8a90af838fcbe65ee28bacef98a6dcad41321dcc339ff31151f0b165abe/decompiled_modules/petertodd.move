module 0xcc98f8a90af838fcbe65ee28bacef98a6dcad41321dcc339ff31151f0b165abe::petertodd {
    struct PETERTODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETERTODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETERTODD>(arg0, 6, b"PETERTODD", b"PeterTodd", b"Who Is Peter Todd, The Man Named By HBO As Bitcoins Mystery Creator Satoshi Nakamoto?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_bdac365809.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETERTODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETERTODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

