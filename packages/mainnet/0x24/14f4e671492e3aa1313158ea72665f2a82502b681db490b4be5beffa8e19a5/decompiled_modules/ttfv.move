module 0x2414f4e671492e3aa1313158ea72665f2a82502b681db490b4be5beffa8e19a5::ttfv {
    struct TTFV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFV>(arg0, 9, b"TTfv", b"fsh", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e7663535b19e92a376573057fadff0c4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

