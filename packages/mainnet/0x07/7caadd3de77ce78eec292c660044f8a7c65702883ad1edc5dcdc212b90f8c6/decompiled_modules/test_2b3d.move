module 0x77caadd3de77ce78eec292c660044f8a7c65702883ad1edc5dcdc212b90f8c6::test_2b3d {
    struct TEST_2B3D has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_2B3D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_2B3D>(arg0, 9, b"Test_2b3d", b"2B3D_test", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1XYQsPWQ5riE8pwtNfWhYA4EfkMFdlXWP/view?usp=sharing")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_2B3D>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_2B3D>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_2B3D>>(v1);
    }

    // decompiled from Move bytecode v6
}

