module 0x1a5e1aa8db01ed0b5423ccace1ef066e0d1483574a7cc941b500386a7d5e0300::p {
    struct P has drop {
        dummy_field: bool,
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P>(arg0, 9, b"P", b"Paws", b"Meme coin for Dogs lovers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3932544c-60a5-4574-ac15-bfc3c3c517c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P>>(v1);
    }

    // decompiled from Move bytecode v6
}

