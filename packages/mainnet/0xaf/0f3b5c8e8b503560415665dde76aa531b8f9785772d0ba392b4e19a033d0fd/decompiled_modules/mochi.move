module 0xaf0f3b5c8e8b503560415665dde76aa531b8f9785772d0ba392b4e19a033d0fd::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi", x"44756520746f206869676820766f6c756d65206f66205355492c207765206465636964656420746f206c61756e636820244d4f434849206f6e20535549206d616b696e67206f75722070726f6a656374206d756c7469636861696e2e204f6666696369616c20616e6e6f756e63656d656e7473207768656e20776520726561636820426c75654d6f76652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mochi_Logo_7957dff671.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

