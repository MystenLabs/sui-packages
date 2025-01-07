module 0x5d0fa86f8e82cdad79d432807d2fa3bf2af9216604dac25788c9d239ec579d11::ncat {
    struct NCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCAT>(arg0, 6, b"NCAT", b"NyanCat", b"Get ready to groove with Nyan Cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_21_14_26_79739e1f1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

