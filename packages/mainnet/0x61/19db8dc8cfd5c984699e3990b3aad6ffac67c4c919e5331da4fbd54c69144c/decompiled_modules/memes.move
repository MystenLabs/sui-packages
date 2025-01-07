module 0x6119db8dc8cfd5c984699e3990b3aad6ffac67c4c919e5331da4fbd54c69144c::memes {
    struct MEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMES>(arg0, 6, b"MEMES", b"Movie of Memens", x"4d6f766965206f66204d656d6573207c205468652062657374206d656d656e732062726f7567687420746f207468652053554920626c6f636b636861696e210a4d454d4d4d4d4d4d4f4f4f4f4f4f4f4f4f4f52520a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_05_22_29_12_82595f0144_275c861f97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

