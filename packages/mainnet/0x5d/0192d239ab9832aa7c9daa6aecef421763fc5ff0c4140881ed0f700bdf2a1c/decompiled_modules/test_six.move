module 0x5d0192d239ab9832aa7c9daa6aecef421763fc5ff0c4140881ed0f700bdf2a1c::test_six {
    struct TEST_SIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_SIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_SIX>(arg0, 9, b"test_six", b"test_six", b"test dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_SIX>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_SIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_SIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

