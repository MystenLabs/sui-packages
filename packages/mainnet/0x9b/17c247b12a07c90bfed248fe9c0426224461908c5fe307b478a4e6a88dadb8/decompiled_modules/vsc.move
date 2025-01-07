module 0x9b17c247b12a07c90bfed248fe9c0426224461908c5fe307b478a4e6a88dadb8::vsc {
    struct VSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSC>(arg0, 9, b"VSC", b"RFG", b"ZCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe92106c-bd1d-4817-b07d-7812eeb917a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

