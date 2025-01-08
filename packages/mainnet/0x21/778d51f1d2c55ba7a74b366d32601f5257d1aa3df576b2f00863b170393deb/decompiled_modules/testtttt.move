module 0x21778d51f1d2c55ba7a74b366d32601f5257d1aa3df576b2f00863b170393deb::testtttt {
    struct TESTTTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTTTT>(arg0, 9, b"TESTTTTT", b"test123", b"sdsdfsfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d8ad461e7fa8e8eb49560bc1df170146blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTTTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTTTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

