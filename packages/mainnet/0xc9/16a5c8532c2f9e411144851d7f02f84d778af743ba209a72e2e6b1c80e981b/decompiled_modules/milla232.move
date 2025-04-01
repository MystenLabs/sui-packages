module 0xc916a5c8532c2f9e411144851d7f02f84d778af743ba209a72e2e6b1c80e981b::milla232 {
    struct MILLA232 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILLA232, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILLA232>(arg0, 9, b"Milla232", b"Milla", b"Ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c0a26fb895344ae057473f05bb41f5b3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILLA232>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILLA232>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

