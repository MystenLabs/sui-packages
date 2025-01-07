module 0x8f8331a75c4b8e49550d3faec10d31160ec067a79638dc7067df8e03499ff359::vsc {
    struct VSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSC>(arg0, 9, b"VSC", b"RFG", b"ZCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a23ec70-5fa7-4157-a60e-4bb5cffeb814.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

