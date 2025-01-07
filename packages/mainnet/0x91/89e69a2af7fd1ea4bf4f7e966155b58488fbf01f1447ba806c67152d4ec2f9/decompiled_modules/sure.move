module 0x9189e69a2af7fd1ea4bf4f7e966155b58488fbf01f1447ba806c67152d4ec2f9::sure {
    struct SURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURE>(arg0, 9, b"SURE", b"sue", b"I sure you should buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e05bb4fe942132b4eab896c9a86cc7e4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

