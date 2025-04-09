module 0x32e4c3812fec21ce57973ec9d9bd4ffc6bd3f7d9c3f505fe587ee74e9dddd1e9::haccho {
    struct HACCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACCHO>(arg0, 9, b"HACCHO", b"yo haccho", b"only for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/860798ad7f5c92b75b4fd6dd577db4efblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACCHO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACCHO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

