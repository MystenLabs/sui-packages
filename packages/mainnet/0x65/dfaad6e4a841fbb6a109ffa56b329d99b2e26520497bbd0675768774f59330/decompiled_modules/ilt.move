module 0x65dfaad6e4a841fbb6a109ffa56b329d99b2e26520497bbd0675768774f59330::ilt {
    struct ILT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILT>(arg0, 9, b"ILT", b"ILIT", b"ILIT It new Performance ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfbf7c07-fc4c-414f-9125-fbfebf151c3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILT>>(v1);
    }

    // decompiled from Move bytecode v6
}

