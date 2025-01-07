module 0xab5a754dc327e63223127742c7a395f7f5f08b2db3c6deeba84ff66af0717cce::moa {
    struct MOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOA>(arg0, 9, b"MOA", b"Moamoa", x"436869e1babf6e20c49169206165", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf2f9ae2-ce72-4d1d-9c92-ce6b0d012bed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

