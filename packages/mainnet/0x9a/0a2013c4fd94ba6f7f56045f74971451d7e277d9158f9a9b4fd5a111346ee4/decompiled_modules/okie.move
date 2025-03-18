module 0x9a0a2013c4fd94ba6f7f56045f74971451d7e277d9158f9a9b4fd5a111346ee4::okie {
    struct OKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKIE>(arg0, 9, b"OKIE", b"Perfect", b"sdfdfsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5dda2733b7d16bd51979562a52226b7dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

