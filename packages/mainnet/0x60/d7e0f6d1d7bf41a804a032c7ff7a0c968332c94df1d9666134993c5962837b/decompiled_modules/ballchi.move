module 0x60d7e0f6d1d7bf41a804a032c7ff7a0c968332c94df1d9666134993c5962837b::ballchi {
    struct BALLCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLCHI>(arg0, 6, b"BALLCHI", b"BallChi Meow", x"0a57697468206c6172676520726f756e64206579657320616e6420696e66696e69746520656e657267792c2049276d2042616c6c436869", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/429206770_1439574496633397_5902276873567660641_n_8aaff796e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

