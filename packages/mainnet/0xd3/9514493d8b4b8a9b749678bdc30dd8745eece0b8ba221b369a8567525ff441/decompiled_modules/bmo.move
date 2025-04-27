module 0xd39514493d8b4b8a9b749678bdc30dd8745eece0b8ba221b369a8567525ff441::bmo {
    struct BMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMO>(arg0, 9, b"BMO", b"Black Mouse", x"426c61636b204d6f75736520e2809420536d616c6c20427574204d696768747920696e2074686520576f726c64206f662043727970746f2120f09f90adf09f96a4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/707e9b51c86af7d069df6bb5fe095f6eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

