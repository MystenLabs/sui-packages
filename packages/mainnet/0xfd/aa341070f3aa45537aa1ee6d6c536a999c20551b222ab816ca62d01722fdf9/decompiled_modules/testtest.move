module 0xfdaa341070f3aa45537aa1ee6d6c536a999c20551b222ab816ca62d01722fdf9::testtest {
    struct TESTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTEST>(arg0, 9, b"testtest", b"testtest", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTTEST>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

