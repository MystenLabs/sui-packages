module 0xc3cd219db1ee4df911a69dcaf22947c2ca1138a3a5e5c37968e27ccbe71ab571::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"The Blue X", b"The Blue X on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_cf184fee0b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X>>(v1);
    }

    // decompiled from Move bytecode v6
}

