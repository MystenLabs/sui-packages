module 0x1265ab2d22753618230abd28dbbcef8d53db3673d8c0d152807de1be099e2075::agw {
    struct AGW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGW>(arg0, 9, b"AGW", b"Agus", b"Myname", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7409f3d-1388-45d7-8519-edeb254e858d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGW>>(v1);
    }

    // decompiled from Move bytecode v6
}

