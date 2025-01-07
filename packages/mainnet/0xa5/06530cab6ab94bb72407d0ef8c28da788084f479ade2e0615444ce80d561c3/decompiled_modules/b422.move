module 0xa506530cab6ab94bb72407d0ef8c28da788084f479ade2e0615444ce80d561c3::b422 {
    struct B422 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B422, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B422>(arg0, 9, b"B422", b"Benbk", b"This is first test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/367863a0-e6a1-46ee-887f-72c5b071defb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B422>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B422>>(v1);
    }

    // decompiled from Move bytecode v6
}

