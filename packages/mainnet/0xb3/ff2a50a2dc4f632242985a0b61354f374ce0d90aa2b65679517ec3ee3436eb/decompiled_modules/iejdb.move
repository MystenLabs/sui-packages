module 0xb3ff2a50a2dc4f632242985a0b61354f374ce0d90aa2b65679517ec3ee3436eb::iejdb {
    struct IEJDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEJDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEJDB>(arg0, 9, b"IEJDB", b"jeneb", b"dhjdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e4a4d16-a808-4bd0-afeb-a81a85f2a296.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEJDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IEJDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

