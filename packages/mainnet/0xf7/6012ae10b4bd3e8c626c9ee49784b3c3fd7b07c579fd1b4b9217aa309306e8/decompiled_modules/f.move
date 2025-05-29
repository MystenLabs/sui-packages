module 0xf76012ae10b4bd3e8c626c9ee49784b3c3fd7b07c579fd1b4b9217aa309306e8::f {
    struct F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F>(arg0, 9, b"F", b"Wiw ", b"Wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b02618da3b9fa6bd88e41f9c12660fa2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

