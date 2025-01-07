module 0x5651ae924fbe5ec9d42d8001e6ea6cd1e64f8c8fe84547624dae2a078832ca7e::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"HCAT", b"High Cat", x"4e696767617320697473206e6f742068656c6c636174202d2069747320484947484341540a0a6d656f77205e5f5e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8876_cbdcbb7818.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

