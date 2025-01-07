module 0xe339d6af5faafafb3d108875aabd782d034b3229679ac2df2cd658242e00cddd::catmeme {
    struct CATMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMEME>(arg0, 6, b"CATMEME", b"CAT", b"Cat is perfect <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBVAXGJ5QWZFF04ERMBMSZEF/01JCCCBVM3C70A7R703E0F21VP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

