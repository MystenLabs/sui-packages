module 0xb338852bb04d41ac8f9ed2ee529c639d6588ed6a567acce19f4ae8b51882bf8f::orgasm {
    struct ORGASM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGASM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGASM>(arg0, 9, b"ORGASM", b"Orgasm AI", x"4465736372697074696f6e3a204e53465720414920636f6e74656e742067656e65726174696f6e2c20696e636c7564696e67206172742c2068656e74616920616e64206d6f72652e0a496e74657261637469766520636861742077697468204149207468617420756e6465727374616e647320796f757220646573697265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS3Sk3pArfZa18vntkCXs1fb4DiDhNParV8LXNRa6YoZE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ORGASM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORGASM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGASM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

