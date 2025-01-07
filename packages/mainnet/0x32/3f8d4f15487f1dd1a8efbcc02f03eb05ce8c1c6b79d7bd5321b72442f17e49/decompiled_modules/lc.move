module 0x323f8d4f15487f1dd1a8efbcc02f03eb05ce8c1c6b79d7bd5321b72442f17e49::lc {
    struct LC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LC>(arg0, 6, b"LC", b"Lucky Calf", x"4c75636b792043616c66206d65616e7320746861742074686520686f6c6465722063616e20676574206c75636b79206275666620696e20746869732062756c6c206d61726b65742e0a54686520636f696e20686f6c64696e6720616464726573732068617320746865206f70706f7274756e69747920746f206765742061204c75636b792043616c66204e46542c2077697468206120746f74616c206f662031302c303030207069656365732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049744_b08bf0d123.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LC>>(v1);
    }

    // decompiled from Move bytecode v6
}

