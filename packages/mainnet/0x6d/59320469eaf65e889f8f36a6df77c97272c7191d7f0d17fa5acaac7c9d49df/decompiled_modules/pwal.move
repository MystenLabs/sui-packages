module 0x6d59320469eaf65e889f8f36a6df77c97272c7191d7f0d17fa5acaac7c9d49df::pwal {
    struct PWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWAL>(arg0, 9, b"Pwal", b"plushwal", b"World of plush start with walrus. take it now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48d2df8135bc373da03f0c2125813f3eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

