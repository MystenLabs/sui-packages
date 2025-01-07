module 0x3cc7b32c28676f488f45b8a6dbf072c03e8c8f9fc375adf5df600ce1fc615f75::te {
    struct TE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TE>(arg0, 9, b"TE", b"Test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c5184dcbabee5b00c5695c0ef42e447ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

