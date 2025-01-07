module 0x637be293f9e9eaa173da64b89f637322fa2545cd01852bfb82233a63f1224062::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 9, b"MOG", b"Chocobo", b"Inspired from Final Fanatsy Chocobo and mogle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/115ea664-72f4-483b-8e59-fcf4450699e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

