module 0x483289668b69678553d00964926e522d76f2a3f57ea4d63667b02e41293f3c30::nep {
    struct NEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEP>(arg0, 9, b"NEP", b"NEPTUNE", b"Token for WAVE Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4817d8af-7da0-4e09-9cb6-f95cccfa60b9-1921144_1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

