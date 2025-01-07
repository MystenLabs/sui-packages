module 0xe50861299b7b5e9214acbc5034bf94f0230719c37e6c7555318b2f7d0ee7a70f::anph {
    struct ANPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANPH>(arg0, 9, b"ANPH", b"Andrew", b"Andrew meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a64e1563-5d86-4261-bc68-2d07555c0b4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

