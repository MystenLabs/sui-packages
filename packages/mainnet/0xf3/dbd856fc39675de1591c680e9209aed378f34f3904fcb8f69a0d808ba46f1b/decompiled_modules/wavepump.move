module 0xf3dbd856fc39675de1591c680e9209aed378f34f3904fcb8f69a0d808ba46f1b::wavepump {
    struct WAVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUMP>(arg0, 9, b"WAVEPUMP", b"Wave ", b"Wave wallet is the best project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e20e714b-2e87-45fd-92d9-c5a7a793756d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

