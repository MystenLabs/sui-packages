module 0xfa8561e657a2806bc3465ad07681f37810f84c95fa950af751e0fe9bfeb9240f::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"test", b"@suilaunchcoin $test + test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/test-04yowo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

