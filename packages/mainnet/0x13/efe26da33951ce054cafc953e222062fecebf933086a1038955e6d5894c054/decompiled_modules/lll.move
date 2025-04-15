module 0x13efe26da33951ce054cafc953e222062fecebf933086a1038955e6d5894c054::lll {
    struct LLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLL>(arg0, 9, b"LLL", b"LTL", b"good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ba7b5cee5c1739af4dc921f01ab7067bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

