module 0x6915c0f1a1251c03c0d7fcacc906061602462921657ca14368654a9f5a998fc9::pajeet {
    struct PAJEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAJEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAJEET>(arg0, 6, b"PAJEET", b"DEV BASED BUT HOLDER JEETED", x"57454c434f4d4520544f2048454c4c2057485920594f55204a4f494e204944494f5420594f552057414e54204c4f5345204d4f4e4559204c45545320425559205448495320534849540a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_11_22_27_07_1f3303b8d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAJEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAJEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

