module 0xc27437996fb511a1db9da3bf7f13da5317ff99903a302c74ce17c2bf7faceb16::sof {
    struct SOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOF>(arg0, 6, b"SOF", b"SUI ON FIRE", x"6d697373206f757420616e6420534f4c206f6e20534f4c3f206c65742773206d616b65207375692074686520686f74206e657720636861696e2e2e2e2e2e2e20616e64207468697320746f6b656e2063616e20626520746865206d6173636f7421212120465941482121212121210a5447206f70656e2c20736f6369616c7320746f20666f6c6c6f77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_842b28b128.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

