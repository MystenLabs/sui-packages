module 0x42e234b024f62440c1bd5b59ed83720821f675212e04b6d7a2b14c3525d327b1::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 6, b"DICK", b"D1CK", b"Big D1ck rulez", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig2cr662fur3hlzco4yoh4ju66brmnxr3v4xxa2322nacaehsz7a4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

