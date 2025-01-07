module 0xac8c9fc7eef9d6afab9d2c1acbbd4a96f355206e2c230cc50960dfe474d6b4fe::mocat {
    struct MOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCAT>(arg0, 6, b"MOCAT", b"MOMO CAT", b"MomoMagicCat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_70_7dcc71af94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

