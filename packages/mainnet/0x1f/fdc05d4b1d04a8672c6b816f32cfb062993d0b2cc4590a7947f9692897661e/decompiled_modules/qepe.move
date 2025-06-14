module 0x1ffdc05d4b1d04a8672c6b816f32cfb062993d0b2cc4590a7947f9692897661e::qepe {
    struct QEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QEPE>(arg0, 9, b"QEPE", b"$QEPE", x"7361746f736869203230323220c2a9efb88fe284a2efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5c1517665d67778e7064d9dc0aeac8bdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

