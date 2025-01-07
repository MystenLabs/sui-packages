module 0x3a3fe480741da3ca24f5d50acdaeee0278fbad468839a5b97adb6a8bd38bd73d::turbocat {
    struct TURBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOCAT>(arg0, 6, b"TURBOCAT", b"Turbo Cat", x"486f704361740a0a48692c2049276d20486f702c2074686520636f6f6c657374206361740a6f6e2073756921205965732c2049276d206c696b652074686174202d20490a6a756d70206c696b652061207265616c206174686c6574652c206f720a616c6d6f73742e2e2e20427574206576657279206a756d7020490a6d616b6520697320612073686f772120416c736f2c0a6265747765656e20796f7520616e64206d652c2049206c6f76650a746f2065617420666973682e0a0a46697368206973206d79207765616b6e6573732c2062757420646f6e27740a7468696e6b2074686174206d616b6573206d65206661742e204f682c0a6e6f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989965008.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

