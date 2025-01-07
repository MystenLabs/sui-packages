module 0x88e9fe032e210750b2811e6d809cc3e0993ca54ef9d134a5c6294dfd8b966222::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 9, b"MAGA", b"MAGA coin", b"Make America great again ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47891017-88b3-41b9-9d54-5de47d63e9e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

