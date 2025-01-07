module 0xbd6dde9f42a6ee97c08aafc35060a96cc398ce537fe222f6490d88b2f93a86e5::vsc {
    struct VSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSC>(arg0, 9, b"VSC", b"RFG", b"ZCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1252a9b6-d3cb-4cf6-8579-2aa7628b03b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

