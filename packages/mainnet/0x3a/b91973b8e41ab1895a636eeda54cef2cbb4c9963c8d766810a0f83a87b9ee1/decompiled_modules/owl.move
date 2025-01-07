module 0x3ab91973b8e41ab1895a636eeda54cef2cbb4c9963c8d766810a0f83a87b9ee1::owl {
    struct OWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWL>(arg0, 6, b"OWL", b"OWL SUI", x"5765617279204f776c20697320616e206f776c20686176696e6720616e20756e6c75636b792064617920427574206865277320747279696e672c20746f2074616b652069742c20646179206279206461790a0a57656c636f6d6520746f204f574c20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10e201a64a834b1b60dad3c77f11a071_d02af725fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

