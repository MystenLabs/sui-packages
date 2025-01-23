module 0x42f8a32d7b90b060df409abe90266c69f36b9a1d22a1f91fac6b4cdd278848d1::ml {
    struct ML has drop {
        dummy_field: bool,
    }

    fun init(arg0: ML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ML>(arg0, 9, b"ML", b"MIMI AND LEO", b"MIMI IS A F AND L IS A M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ce88f69951a00b4015360c4a3f78b914blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ML>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ML>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

