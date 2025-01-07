module 0xc68e3ad4d0868ce9372834763f8f4c51ae30d0c41aa0aa68755e866f78609a19::omo {
    struct OMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMO>(arg0, 9, b"OMO", b"OMAIRO", b"Just buy and hold for a long run, e go pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0a89f84-a22d-4d0b-9c5e-e96ebf08a55d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

