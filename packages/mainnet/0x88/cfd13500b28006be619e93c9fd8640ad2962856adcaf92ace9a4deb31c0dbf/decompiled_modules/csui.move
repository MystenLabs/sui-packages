module 0x88cfd13500b28006be619e93c9fd8640ad2962856adcaf92ace9a4deb31c0dbf::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 9, b"CSUI", b"SUI COM", b"Sui Community for community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c4c5249-f755-4467-a27b-519f44ab22fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

