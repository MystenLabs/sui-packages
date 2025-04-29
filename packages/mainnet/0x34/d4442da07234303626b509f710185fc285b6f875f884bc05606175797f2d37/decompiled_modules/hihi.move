module 0x34d4442da07234303626b509f710185fc285b6f875f884bc05606175797f2d37::hihi {
    struct HIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHI>(arg0, 9, b"HIHI", b"HIHICOIN", b"HI HOW ARE YOU DOING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/228ea6f5a0b4bb9dbe5f628cc5e80f8fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

