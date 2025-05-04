module 0x43c3a42c2b870295015347ce479b7bb3b1cebd9ec6cb96c318c4536979d82fe4::smkcat {
    struct SMKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMKCAT>(arg0, 6, b"SMKCAT", b"SMOKINCAT", b"SMOKINCAT returns to Leake Street, leaving claw marks in the underworld. First strike of the seasonlove is a loaded weapon. The wall listens, the shadows grin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250505_002609_1bbe0d89ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

