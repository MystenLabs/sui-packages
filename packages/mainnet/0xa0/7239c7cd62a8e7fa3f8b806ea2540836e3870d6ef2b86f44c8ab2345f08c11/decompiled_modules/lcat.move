module 0xa07239c7cd62a8e7fa3f8b806ea2540836e3870d6ef2b86f44c8ab2345f08c11::lcat {
    struct LCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCAT>(arg0, 6, b"LCAT", b"Lioncat", x"4c43415420746f20746865204d6f6f6e2120426c617374696e67207468726f7567682067616c61786965732c0a6f6e6520726f617220617420612074696d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lionc_e747574063.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

