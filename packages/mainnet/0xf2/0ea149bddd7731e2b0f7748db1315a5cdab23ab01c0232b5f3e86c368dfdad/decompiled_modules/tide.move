module 0xf20ea149bddd7731e2b0f7748db1315a5cdab23ab01c0232b5f3e86c368dfdad::tide {
    struct TIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIDE>(arg0, 9, b"TIDE", b"Tide", x"496e74726f647563696e6720544944452c20746865206d656d65636f696e20726964696e67207761766573206f6620696e7465726e65742068797065212055702c20646f776e2c206f72206a757374206472696674696e67e2809454494445206973206865726520746f2072656d696e6420796f753a20776861742073696e6b73206d69676874206a7573742073757266206261636b2075702120f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58eff5cc-4d32-47a9-8319-da69c0f4358b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

