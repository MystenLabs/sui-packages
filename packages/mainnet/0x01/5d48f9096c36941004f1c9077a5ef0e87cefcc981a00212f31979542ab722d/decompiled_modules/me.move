module 0x15d48f9096c36941004f1c9077a5ef0e87cefcc981a00212f31979542ab722d::me {
    struct ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ME>(arg0, 9, b"ME", b"Meow", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5f3f1ac-ea36-4bf2-8f82-3d973746a63c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ME>>(v1);
    }

    // decompiled from Move bytecode v6
}

