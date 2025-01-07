module 0x6ee9e30d15d9cca1540414798d2689a8df6acb4844ea13401df5c9210d4d5676::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 9, b"T", b"T", b"None", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T>>(v1);
    }

    // decompiled from Move bytecode v6
}

