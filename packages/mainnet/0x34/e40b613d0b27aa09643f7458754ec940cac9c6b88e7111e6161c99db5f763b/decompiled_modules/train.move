module 0x34e40b613d0b27aa09643f7458754ec940cac9c6b88e7111e6161c99db5f763b::train {
    struct TRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAIN>(arg0, 6, b"TRAIN", b"Thomas The Pump Train", x"2054686f6d6173206973206261636b2066726f6d20796f7572206368696c6420686f6f6420746f2050414d50207468696e6773205550210a0a20576974682068697320726574617264656420667269656e647320746865726520617265206e6f206c696d69747320746f20686f77206661722054686f6d61732063616e2050414d50210a0a2043484f4f212043484f4f21206e616868682050414d50212050414d5021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1094_f39a100d8f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

