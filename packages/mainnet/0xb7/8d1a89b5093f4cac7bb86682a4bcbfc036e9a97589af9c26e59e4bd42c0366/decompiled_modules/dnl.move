module 0xb78d1a89b5093f4cac7bb86682a4bcbfc036e9a97589af9c26e59e4bd42c0366::dnl {
    struct DNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNL>(arg0, 9, b"DNL", b"DoNotLock", b"Don't lock the meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/244aa1b5bd7cb6fc1ac4be169f4b0f41blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

