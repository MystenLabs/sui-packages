module 0x3ab8df5547b2746c7e4b22f70ab2b2588bbf72ef80dfbfe3b6b4833d5ca456e::sui8008 {
    struct SUI8008 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI8008, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI8008>(arg0, 9, b"SUI8008", b"8008", b"Everyone Loves (.)(.)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fcf7e9cb91b1ce026b97abcece4db4acblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI8008>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI8008>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

