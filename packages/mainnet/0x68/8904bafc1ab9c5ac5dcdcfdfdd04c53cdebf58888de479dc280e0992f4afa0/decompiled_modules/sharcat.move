module 0x688904bafc1ab9c5ac5dcdcfdfdd04c53cdebf58888de479dc280e0992f4afa0::sharcat {
    struct SHARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARCAT>(arg0, 6, b"SHARCAT", b"Shark Cat", b"PHASE 2 SOON...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008834_7dcb94cea5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

