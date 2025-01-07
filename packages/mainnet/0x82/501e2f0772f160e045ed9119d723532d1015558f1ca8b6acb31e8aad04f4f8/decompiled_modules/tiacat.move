module 0x82501e2f0772f160e045ed9119d723532d1015558f1ca8b6acb31e8aad04f4f8::tiacat {
    struct TIACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIACAT>(arg0, 6, b"TIACAT", b"Tia Mask Cat", b"The real cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_92dd741b82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

