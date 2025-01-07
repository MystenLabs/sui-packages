module 0xffcf275ba8c2f5351b50196fb8378b82637ec072e28b927bf33e4160dfcdfecd::nept {
    struct NEPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPT>(arg0, 9, b"NEPT", b"NEPTUNE", b"Memcoin for WAVE Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f25d2916-b0ed-4b56-a307-09122fc2c2e0-1921144_1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

