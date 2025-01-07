module 0xbc25b25803bbc68d0eef4b7b78927fb8b06b9ba8f7882437dac2dcebdc201a56::cab {
    struct CAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAB>(arg0, 9, b"CAB", b"Cable Meme", b"Cable Door", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f06e3521-23ee-44dc-a7ac-8b16f3235656.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

