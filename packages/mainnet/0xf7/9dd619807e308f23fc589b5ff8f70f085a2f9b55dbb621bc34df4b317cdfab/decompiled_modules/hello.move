module 0xf79dd619807e308f23fc589b5ff8f70f085a2f9b55dbb621bc34df4b317cdfab::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 9, b"HELLO", b"Hello", b"Official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HELLO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

