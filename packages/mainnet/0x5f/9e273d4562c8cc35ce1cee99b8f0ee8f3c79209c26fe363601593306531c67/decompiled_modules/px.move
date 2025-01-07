module 0x5f9e273d4562c8cc35ce1cee99b8f0ee8f3c79209c26fe363601593306531c67::px {
    struct PX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PX>(arg0, 9, b"PX", b"PIXEL", b"Not Pixel token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1dfa18be-559f-4b8c-8d92-3b677ad54cf6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PX>>(v1);
    }

    // decompiled from Move bytecode v6
}

