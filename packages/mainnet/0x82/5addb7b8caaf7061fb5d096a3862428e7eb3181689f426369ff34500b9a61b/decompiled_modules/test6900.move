module 0x825addb7b8caaf7061fb5d096a3862428e7eb3181689f426369ff34500b9a61b::test6900 {
    struct TEST6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST6900>(arg0, 9, b"TEST6900", b"TEST FINAL", b"TEST DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_67eba9a55bde83.81251250.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

