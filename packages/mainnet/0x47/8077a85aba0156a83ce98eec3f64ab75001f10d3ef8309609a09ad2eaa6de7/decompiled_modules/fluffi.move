module 0x478077a85aba0156a83ce98eec3f64ab75001f10d3ef8309609a09ad2eaa6de7::fluffi {
    struct FLUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFI>(arg0, 6, b"FLUFFI", b"FLUFFINGTON", x"41206e656f6e2d677265656e206d617273686d616c6c6f772063686172616374657220626f726e2066726f6d20612073757065726e6f766120616e64206f6e2061206d697373696f6e20746f20737072656164206c61756768746572206279207469636b6c696e6720626c61636b20686f6c657320696e746f206372656174696e67206e65772073746172730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6078075501135642635_c_e7888c07a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

