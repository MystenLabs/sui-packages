module 0x3d46c90b4ead309ffd1b279c6bfe5b7732912c4fc77021c83dbd8d2e0b3fdd15::wabbit {
    struct WABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WABBIT>(arg0, 6, b"WABBIT", b"SUI WABBIT", b"A degenerate rabbit lands on SUI, spreading chaos and laughter in its wake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3041_3a917be1ee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

