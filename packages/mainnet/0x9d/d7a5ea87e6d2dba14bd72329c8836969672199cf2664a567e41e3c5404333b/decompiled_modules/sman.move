module 0x9dd7a5ea87e6d2dba14bd72329c8836969672199cf2664a567e41e3c5404333b::sman {
    struct SMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAN>(arg0, 9, b"SMan", b"strong man", b"Strong and fit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/04690926677661687fa7bfa68c23ecbbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

