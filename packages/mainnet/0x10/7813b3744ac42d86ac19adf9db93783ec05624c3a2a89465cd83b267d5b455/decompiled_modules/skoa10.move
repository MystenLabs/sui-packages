module 0x107813b3744ac42d86ac19adf9db93783ec05624c3a2a89465cd83b267d5b455::skoa10 {
    struct SKOA10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOA10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKOA10>(arg0, 9, b"Skoa10", b"faunameme", b"let s save the animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7244856dedb59b2b2d75a55b95ddcbaeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKOA10>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOA10>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

