module 0x4cc09db855b90ecaabb4b4689625031cf2b89f80496d34fc2dc6e1056d6051b6::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 6, b"TEST2", b"TEST 2", b"don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/19e021cce5691f7a3a1f4f791b39a3c1_843ad4ca3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST2>>(v1);
    }

    // decompiled from Move bytecode v6
}

