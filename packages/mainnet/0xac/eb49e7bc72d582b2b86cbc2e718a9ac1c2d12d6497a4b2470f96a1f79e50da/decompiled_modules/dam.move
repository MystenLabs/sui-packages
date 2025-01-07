module 0xaceb49e7bc72d582b2b86cbc2e718a9ac1c2d12d6497a4b2470f96a1f79e50da::dam {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 9, b"DAM", b"DAMEA", b"aaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2566ac19-9cbd-423f-bba4-3f9a031a973b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

