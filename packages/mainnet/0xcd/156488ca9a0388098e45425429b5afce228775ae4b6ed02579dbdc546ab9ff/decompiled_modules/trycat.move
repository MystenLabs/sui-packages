module 0xcd156488ca9a0388098e45425429b5afce228775ae4b6ed02579dbdc546ab9ff::trycat {
    struct TRYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYCAT>(arg0, 6, b"TRYCAT", b"Trilly da cat", b"Just my cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5789509799707263752_y_2bd8da16ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

