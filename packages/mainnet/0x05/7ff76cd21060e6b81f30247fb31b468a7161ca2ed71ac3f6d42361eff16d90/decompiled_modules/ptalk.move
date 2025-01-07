module 0x57ff76cd21060e6b81f30247fb31b468a7161ca2ed71ac3f6d42361eff16d90::ptalk {
    struct PTALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTALK>(arg0, 9, b"PTALK", b"pitchtalk", b"1805", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bbcd134-3f11-45e2-9101-d33d98d979ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

