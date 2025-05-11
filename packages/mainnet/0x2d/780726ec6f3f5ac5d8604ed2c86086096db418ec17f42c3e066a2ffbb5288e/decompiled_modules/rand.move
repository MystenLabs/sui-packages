module 0x2d780726ec6f3f5ac5d8604ed2c86086096db418ec17f42c3e066a2ffbb5288e::rand {
    struct RAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAND>(arg0, 9, b"RAND", b"RandHash Glitch ", x"52616e644861736820476c6974636820e28093205365726965732031", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fd6ded9d2c5282cec24351ff6aad6576blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

