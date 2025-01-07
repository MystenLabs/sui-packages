module 0x4598356c376d69ace3b0919c6c6e93c3e2017813c3b7c1546f46e695e1e06de5::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"Godcandle", b"What's crypto without a Godcandle? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Group_7_3_203884b45c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

