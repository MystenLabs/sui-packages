module 0x2d961b9baca2b70deceda37e7df09d0e81a93020e188b61a42dc4d41407de1fb::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HopCat", b"HopCatSui", x"48692c2049276d20486f702c2074686520636f6f6c65737420636174206f6e2073756921205965732c2049276d206c696b650a74686174202d2049206a756d70206c696b652061207265616c206174686c6574652c206f7220616c6d6f73742e2e2e204275740a6576657279206a756d702049206d616b6520697320612073686f772120416c736f2c206265747765656e20796f750a616e64206d652c2049206c6f766520746f2065617420666973682e0a0a46697368206973206d79207765616b6e6573732c2062757420646f6e2774207468696e6b2074686174206d616b6573206d65206661742e0a4f682c206e6f212049742773206a75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985163725.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

