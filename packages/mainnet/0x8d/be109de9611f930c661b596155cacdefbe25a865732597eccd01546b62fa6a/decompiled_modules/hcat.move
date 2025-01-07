module 0x8dbe109de9611f930c661b596155cacdefbe25a865732597eccd01546b62fa6a::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"HCAT", b"High Cat", b"A cat, which is high ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8876_74d267c071.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

