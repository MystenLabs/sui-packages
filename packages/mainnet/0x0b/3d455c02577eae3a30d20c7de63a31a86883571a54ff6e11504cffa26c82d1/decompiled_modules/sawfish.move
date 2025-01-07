module 0xb3d455c02577eae3a30d20c7de63a31a86883571a54ff6e11504cffa26c82d1::sawfish {
    struct SAWFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAWFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAWFISH>(arg0, 6, b"SAWFISH", b"Sawfish", b"With a touch of humor and a vibrant community, $SAWFISH is ready to slice through market resistance with its sharp \"saw\" and unstoppable spirit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/We_are_live_at_Movepump_6_7cfb079275.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAWFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAWFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

