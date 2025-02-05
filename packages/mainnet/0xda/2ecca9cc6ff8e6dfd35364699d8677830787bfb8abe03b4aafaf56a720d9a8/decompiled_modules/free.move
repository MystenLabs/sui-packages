module 0xda2ecca9cc6ff8e6dfd35364699d8677830787bfb8abe03b4aafaf56a720d9a8::free {
    struct FREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREE>(arg0, 9, b"FREE", b"FREE Token", b"Free token for Sniping Record", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d96eeb9d-c16d-4497-bd0c-787ee6398346.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

