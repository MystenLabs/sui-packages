module 0xccee8b5b1f3ef927fa57e22440e02f463fcfb4badc16305e723cec6de9633d01::bandi {
    struct BANDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDI>(arg0, 6, b"BANDI", b"Bandido", x"42616e6469646f0a41207265736375656420707570206f6e2061206d697373696f6e2c206d616b696e67206761696e7320746f20737570706f727420616e696d616c207368656c7465727320616e64206769766520667572727920667269656e64732061207365636f6e64206368616e636521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bandi_6fb575f2f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

