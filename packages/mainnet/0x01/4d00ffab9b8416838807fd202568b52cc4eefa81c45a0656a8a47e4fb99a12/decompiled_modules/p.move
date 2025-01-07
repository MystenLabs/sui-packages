module 0x14d00ffab9b8416838807fd202568b52cc4eefa81c45a0656a8a47e4fb99a12::p {
    struct P has drop {
        dummy_field: bool,
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P>(arg0, 9, b"P", b"PIGEON", b"MEME PIGEON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/469e73ef-821e-43ed-9434-6ff0136c65b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P>>(v1);
    }

    // decompiled from Move bytecode v6
}

