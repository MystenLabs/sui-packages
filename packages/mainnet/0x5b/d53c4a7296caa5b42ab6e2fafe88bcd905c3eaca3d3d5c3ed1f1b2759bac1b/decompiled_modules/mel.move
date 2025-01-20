module 0x5bd53c4a7296caa5b42ab6e2fafe88bcd905c3eaca3d3d5c3ed1f1b2759bac1b::mel {
    struct MEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEL>(arg0, 9, b"MEL", b"Melania", b"Melania Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/113631d01f3f15cc095a093fdf968fe4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

