module 0xf9424854fcee82dc268413425a0f3b46ccfa515eb3fa0dd384bc0d879791eca::shdw {
    struct SHDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHDW>(arg0, 9, b"SHDW", b"ShadwToken", b"shadow token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13a0f0ba-c18d-4a3d-b18b-d08136d17206.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHDW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHDW>>(v1);
    }

    // decompiled from Move bytecode v6
}

