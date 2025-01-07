module 0xda7ed75389e463de30cfbe71bf006e21552b726c0a60081ff3ed07f9fd979a85::mnr {
    struct MNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNR>(arg0, 9, b"MNR", b"Mansour", b"Mnrtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/167217d5-98c4-492a-a689-230465634981.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

