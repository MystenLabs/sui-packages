module 0xa85d1701e2a4e52511851c9a781217b0ecd484630a69297817b46b90d6907a16::frt {
    struct FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRT>(arg0, 9, b"FRT", b"Frog", b"Just a frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f6d0e15-3072-48bb-8c67-15b2ae0fe2c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

