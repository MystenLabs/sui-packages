module 0x37a6f0ff802abbf5ad7d7282f41fcdfa006b63a948990fc3bb7aa5e41dfc7f2c::vsc {
    struct VSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSC>(arg0, 9, b"VSC", b"RFG", b"ZCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b814c0df-f342-4fd0-a72d-1807789cd7ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

