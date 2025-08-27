module 0x4529eaf29c4b5e67cfb0ca3240714b8ff37270de3da94bf714180fb6daea24fc::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 9, b"TESTTOKEN", b"TEST TOKEN", b"TEST TOKENTEST TOKENTEST TOKENTEST TOKENTEST TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTTOKEN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v2, @0x4214f3746036a6dfdbabc23b04deab00ecc63014e9f1ae660614441386e5732e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

