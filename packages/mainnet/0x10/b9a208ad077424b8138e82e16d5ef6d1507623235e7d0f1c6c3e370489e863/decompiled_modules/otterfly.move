module 0x10b9a208ad077424b8138e82e16d5ef6d1507623235e7d0f1c6c3e370489e863::otterfly {
    struct OTTERFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTERFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTERFLY>(arg0, 6, b"OTTERFLY", b"OTTERFLY SUI", b"This is $OTTERFLY a flying otter from uptober with many adorable facial expressions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_23_39_37_5d21aa63cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTERFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTERFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

