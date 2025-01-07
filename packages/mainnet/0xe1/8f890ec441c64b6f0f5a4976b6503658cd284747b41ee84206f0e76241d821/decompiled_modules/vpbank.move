module 0xe18f890ec441c64b6f0f5a4976b6503658cd284747b41ee84206f0e76241d821::vpbank {
    struct VPBANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VPBANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VPBANK>(arg0, 9, b"VPBANK", b"VPBank", b"VP bank", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60f6fbad-6431-42a2-a7b4-734843b00cd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VPBANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VPBANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

