module 0xcdbdb5e45474f7e6a353fb806b21f31dc849ddfc82c6081729f5adf700e2c660::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 9, b"PIKA", b"Pokemon", b"chu?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7b2fd75054c82b21932b48f5111a992fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

