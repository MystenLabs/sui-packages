module 0xcf1cf3ae70e3f678b35f57417384c15622a53a96a2b23b60b5b5ab00f6c12035::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 6, b"Test1", b"test", b"1111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/common_room_roasters_long_beach_coffee_shop_480x480_a9880410bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST1>>(v1);
    }

    // decompiled from Move bytecode v6
}

