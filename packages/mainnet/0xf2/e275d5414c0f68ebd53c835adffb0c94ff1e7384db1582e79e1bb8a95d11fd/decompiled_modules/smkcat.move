module 0xf2e275d5414c0f68ebd53c835adffb0c94ff1e7384db1582e79e1bb8a95d11fd::smkcat {
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

