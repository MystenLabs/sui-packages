module 0xb661b5da237697ef241e28259edbe2c89107329d225ae0a6d4bafebdc8b08a33::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 9, b"SAD", b"Sad", b"Sadegh021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a10df0aa-aab2-4feb-a38e-2c4b1f391b1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

