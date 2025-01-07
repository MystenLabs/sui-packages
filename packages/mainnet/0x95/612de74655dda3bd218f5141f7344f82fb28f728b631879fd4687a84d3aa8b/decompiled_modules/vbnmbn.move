module 0x95612de74655dda3bd218f5141f7344f82fb28f728b631879fd4687a84d3aa8b::vbnmbn {
    struct VBNMBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBNMBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VBNMBN>(arg0, 9, b"VBNMBN", b"FGHFG", b"GHJKL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ea1c5dc-0756-46a9-88ac-981a30b6b6a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBNMBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VBNMBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

