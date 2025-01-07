module 0x949b8ad42a08ac777de6ffbce5f7cf3f6c3d6212b908cc97af445ebad4c3eaba::scream {
    struct SCREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCREAM>(arg0, 6, b"Scream", b"Screamm", b"magnet was first. Now scream.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2841_0b685d6d60.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

