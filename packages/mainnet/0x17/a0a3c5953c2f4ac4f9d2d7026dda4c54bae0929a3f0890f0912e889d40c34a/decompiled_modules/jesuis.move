module 0x17a0a3c5953c2f4ac4f9d2d7026dda4c54bae0929a3f0890f0912e889d40c34a::jesuis {
    struct JESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIS>(arg0, 6, b"JESUIS", b"Jesuis Christ", b"Rebirth on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jesuis_pfp_7f8a11247e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

