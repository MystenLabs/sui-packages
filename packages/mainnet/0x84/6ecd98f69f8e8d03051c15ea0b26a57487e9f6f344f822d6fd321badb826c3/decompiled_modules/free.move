module 0x846ecd98f69f8e8d03051c15ea0b26a57487e9f6f344f822d6fd321badb826c3::free {
    struct FREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREE>(arg0, 9, b"FREE", b"Freecoin", b"Freetoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dec7f91c-b461-4b91-a672-7b64142273b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

