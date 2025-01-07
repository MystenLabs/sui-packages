module 0x6f6fae822ac57d86da98f33ee9bd79fd7581b06cbac3e15e39dee27f2c3c1d12::noy {
    struct NOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOY>(arg0, 9, b"NOY", b"SUINOY", b"SUINOY Meme Lover ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3926c1a7-8b95-424e-9084-16e92d2a5cbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

