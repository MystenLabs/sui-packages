module 0xcc4dde0816d83c5dfc409d13b973e159b2e42e974d4cc51fee140197a702e573::msgsphere {
    struct MSGSPHERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGSPHERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGSPHERE>(arg0, 6, b"MSGSphere", b"Sphere", x"4661726577656c6c2c205370686572650a496e20746865206e6967687420736b79206f66204c61732056656761732c20796f752077657265207468652062726967687465737420737461722e20596f757220676c6f772062726f7567687420636f756e746c657373206d6f6d656e7473206f66206a6f7920616e6420776f6e6465722e204576656e20696620796f75206e6f206c6f6e676572207368696e652c20796f7572206272696c6c69616e63652077696c6c206c697665206f6e20696e206f7572206865617274732e205468616e6b20796f752c205370686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_13_06_13_09_c475341f75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGSPHERE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSGSPHERE>>(v1);
    }

    // decompiled from Move bytecode v6
}

