module 0xb37395a1352e4a8d22b3b6936337adbabb3821ffb8e90c2fa6aa5a415a718e21::srt {
    struct SRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRT>(arg0, 9, b"SRT", b"Sui Rabbit", b"We are a meme coin based on the sui blockchain. Our focus is on progress and creating new ideas. Stay with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b935ed3-bf27-4853-8ed7-c71a449e2833.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

