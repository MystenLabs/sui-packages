module 0xfc813f37f2fd0f5a3982bf4bd59bfa44101b445163424d1631ffef1e16b056cf::peter {
    struct PETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETER>(arg0, 6, b"Peter", b"Peter ktood", x"43727970746f6368726f6e6f6d616e636572200a466f756e646572206f6620626974636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022099_a2997be0f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETER>>(v1);
    }

    // decompiled from Move bytecode v6
}

