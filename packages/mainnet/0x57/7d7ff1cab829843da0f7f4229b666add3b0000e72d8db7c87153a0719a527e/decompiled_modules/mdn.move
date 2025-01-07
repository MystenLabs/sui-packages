module 0x577d7ff1cab829843da0f7f4229b666add3b0000e72d8db7c87153a0719a527e::mdn {
    struct MDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDN>(arg0, 9, b"MDN", b"MaDoN", b"BYLDOGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbe75c0a-f5c9-4eb5-8a2b-83a1ffe58149.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

