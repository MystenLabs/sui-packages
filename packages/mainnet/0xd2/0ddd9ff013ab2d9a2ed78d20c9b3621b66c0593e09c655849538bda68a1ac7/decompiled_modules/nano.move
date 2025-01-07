module 0xd20ddd9ff013ab2d9a2ed78d20c9b3621b66c0593e09c655849538bda68a1ac7::nano {
    struct NANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANO>(arg0, 9, b"NANO", b"Banana AI", b"Where banana curves meet AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/11d64326b3fa0ce8026a9f37cbc35b6cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

