module 0xc95169c8c17e9636c306785e5a7d97d42a082e717380575c77fcd3824096c34::socat {
    struct SOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCAT>(arg0, 6, b"SOCAT", b"SUI O CAT", b"Get ready for the ultimate purrfection, humans! hodl SUIOCAT, or face eternal servitude as a personal can-opener for our feline overlords. The meowpocalypse is coming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_19_00_49_15_58c740b5d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

