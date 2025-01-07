module 0x59daf5b5dfa9f2c2f7ed7123863c1ff569710efe805e44c3be45ddc299f58bd5::dan {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN>(arg0, 6, b"Dan", b"The real chad", x"4c69657574656e616e742044616e20737572766976656420487572726963616e65204d696c746f6e20696e20686973203230667420626f6174206166746572207265667573696e6720746f2065766163756174650a0a4e6f772068652773206265656e206f66666572656420612024322c3030302c303030204b69636b206465616c202620243130306b20626f617420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0736_3dce0f7eb0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

