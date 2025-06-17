module 0x4ab6b017215445cf83eca0a0104ef5dc14c48cc4d4810bff04ed20ddeecc5a1c::bio {
    struct BIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIO>(arg0, 9, b"BIO", b"Black it out", b"Just black it out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/364fc6e3ac4fbe7ac07f6b60620e3ab7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

