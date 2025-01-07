module 0x8ce310007912a627b4546ba5550b4bd0b7fb7a2ea7437506f002284459c88729::zb {
    struct ZB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZB>(arg0, 9, b"ZB", b"Zobo", b"Best of the best memes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26abc081-635e-4b29-9138-525c7c4a86fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZB>>(v1);
    }

    // decompiled from Move bytecode v6
}

