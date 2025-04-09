module 0xde2b3da1bbd735dca5a27a09d0192af42f72599192f8d257228c0b82890d00f7::nvctr {
    struct NVCTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVCTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVCTR>(arg0, 9, b"NVCTR", b"invector", b"Vector in fundamental", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/97b57ba57bc2761a8f1a50e3e60263ffblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NVCTR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVCTR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

