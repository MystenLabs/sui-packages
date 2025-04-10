module 0x6c888f2e80ccee115eeb2cb502d30c343bc44700db076726962e8fe029b8fdc4::mmdo {
    struct MMDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMDO>(arg0, 9, b"Mmdo", b"dima", b"77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f9a747cb1c97293a0d006dac9db378b0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

