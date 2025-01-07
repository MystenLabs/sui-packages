module 0x85a3eb7b4b40ab4b5d65f369100ec565f43bc6f08b535d075adca02c497cf7fe::krett {
    struct KRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRETT>(arg0, 6, b"KRETT", b"Krett", x"42726574743f2042726974743f204272657474277320636f7573696e3f20456e6f75676820697320656e6f7567682e20497427732074696d6520746f2064657468726f6e6520427265747420616e64206869732066616d696c792e200a5468697320697320746865204272657474204b696c6c6572202d20244b524554542e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KRETT_0d25bdc537.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

