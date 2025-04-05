module 0xa2b45122d917260b40fd8b4a0ef8e6a5a2cadcba8d9d7cc9b565b9fc3729e9f4::dmn {
    struct DMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMN>(arg0, 9, b"DMN", b"damian", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c9b7fc019088f19b0e0fe088215cbcbcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

