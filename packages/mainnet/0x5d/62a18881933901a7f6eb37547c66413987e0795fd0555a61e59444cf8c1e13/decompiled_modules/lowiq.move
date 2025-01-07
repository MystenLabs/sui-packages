module 0x5d62a18881933901a7f6eb37547c66413987e0795fd0555a61e59444cf8c1e13::lowiq {
    struct LOWIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOWIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOWIQ>(arg0, 6, b"LOWIQ", b"LowIQ", b"Life is better on the left side of the curve $LowIQ.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_f22f2c3df4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOWIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOWIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

