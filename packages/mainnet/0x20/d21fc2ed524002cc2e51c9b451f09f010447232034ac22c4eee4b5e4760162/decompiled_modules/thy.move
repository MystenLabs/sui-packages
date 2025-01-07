module 0x20d21fc2ed524002cc2e51c9b451f09f010447232034ac22c4eee4b5e4760162::thy {
    struct THY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THY>(arg0, 9, b"THY", b"STREET", b"THE STREET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26034f53-16c9-4b06-8c1b-ab3ff22918fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THY>>(v1);
    }

    // decompiled from Move bytecode v6
}

