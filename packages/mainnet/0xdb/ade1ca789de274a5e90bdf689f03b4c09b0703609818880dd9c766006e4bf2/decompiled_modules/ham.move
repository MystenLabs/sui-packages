module 0xdbade1ca789de274a5e90bdf689f03b4c09b0703609818880dd9c766006e4bf2::ham {
    struct HAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAM>(arg0, 9, b"HAM", b"HAMTER", b"khai hamter a cute Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/44a900e7cbd2bf6d2ea088a86bb8ed7dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

