module 0xf0b89d9190ff5896efaf265b86452018eecc7f20666ec15aeeb8c6bc71fb40ab::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUITIFY", x"5355495420434f494e2c20436f6d6d756e6974792d64726976656e2063727970746f63757272656e6379207468617420626c656e6473206d757369632c206d656d65732c20616e6420646563656e7472616c697a65642066696e616e6365202844654669292e20496e7370697265642062792074686520676c6f62616c206d757369632073747265616d696e67206769616e742053706f746966792c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241011_165850_994_6f9b952492.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

