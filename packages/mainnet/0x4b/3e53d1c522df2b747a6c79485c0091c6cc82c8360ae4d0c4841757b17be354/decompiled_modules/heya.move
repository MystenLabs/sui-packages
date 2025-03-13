module 0x4b3e53d1c522df2b747a6c79485c0091c6cc82c8360ae4d0c4841757b17be354::heya {
    struct HEYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEYA>(arg0, 9, b"HEYA", b"Hey", b"fdfe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f0fae6003bd4b0c53e9c04c9a58fbd89blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEYA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

