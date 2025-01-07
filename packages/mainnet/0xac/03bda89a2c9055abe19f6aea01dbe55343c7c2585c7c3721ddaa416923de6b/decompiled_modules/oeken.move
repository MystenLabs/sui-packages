module 0xac03bda89a2c9055abe19f6aea01dbe55343c7c2585c7c3721ddaa416923de6b::oeken {
    struct OEKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEKEN>(arg0, 9, b"OEKEN", b"jenen", x"d0bed0b0d0bbd183", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c088434-f150-4b7f-ae47-8fdf69bb73fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

