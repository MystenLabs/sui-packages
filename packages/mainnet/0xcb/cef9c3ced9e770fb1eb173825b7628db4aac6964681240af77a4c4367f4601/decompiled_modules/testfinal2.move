module 0xcbcef9c3ced9e770fb1eb173825b7628db4aac6964681240af77a4c4367f4601::testfinal2 {
    struct TESTFINAL2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTFINAL2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTFINAL2>(arg0, 9, b"TESTFINAL2", b"TEST FINAL2", b"sdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_67c8ae62db6d24.30180235.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTFINAL2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTFINAL2>>(v1);
    }

    // decompiled from Move bytecode v6
}

