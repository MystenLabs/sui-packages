module 0xeb245e1343fee1c3e77ffb708b3c072ccdee8a561d3788445eb2d4a2aed34854::sidsui {
    struct SIDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDSUI>(arg0, 6, b"SIDSUI", b"SID", x"4368616e67696e672074686520776f726c6420436f6f6b6965204d6f6e73746572202d205349440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sidlogo_ecc04c346f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

