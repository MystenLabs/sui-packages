module 0xb1d2f2affe2a2fb99250a5ca0dbfa96c8ce0289be748d9b79df80d368a9f7f0a::msh {
    struct MSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSH>(arg0, 9, b"MSH", b"Mushrooms", b"Panter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e941636-c2bb-4c59-b29b-a8479b95761f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

