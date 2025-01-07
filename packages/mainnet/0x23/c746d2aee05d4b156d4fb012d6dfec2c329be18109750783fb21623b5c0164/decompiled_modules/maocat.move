module 0x23c746d2aee05d4b156d4fb012d6dfec2c329be18109750783fb21623b5c0164::maocat {
    struct MAOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOCAT>(arg0, 6, b"MaoCat", b"MAO The CAt SUI", b"My plan is to take over the workd not sure how or why?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_001036_236_6b9ee3e48d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

