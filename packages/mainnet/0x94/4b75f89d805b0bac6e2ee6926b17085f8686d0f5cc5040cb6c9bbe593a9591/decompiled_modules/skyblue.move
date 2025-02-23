module 0x944b75f89d805b0bac6e2ee6926b17085f8686d0f5cc5040cb6c9bbe593a9591::skyblue {
    struct SKYBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYBLUE>(arg0, 9, b"SKYBLUE", b"ring sky", b"Like a troubled person, he goes in and wants to get out, and when he comes out he wants to go in.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5aeff3b576f8e2d4655cc65e6439f67eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYBLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYBLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

