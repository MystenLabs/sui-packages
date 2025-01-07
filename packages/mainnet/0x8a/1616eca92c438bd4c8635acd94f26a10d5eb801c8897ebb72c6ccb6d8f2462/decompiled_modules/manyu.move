module 0x8a1616eca92c438bd4c8635acd94f26a10d5eb801c8897ebb72c6ccb6d8f2462::manyu {
    struct MANYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYU>(arg0, 9, b"MANYU", b"Manyu", b"Manyu on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2b82de0-2571-425c-9edc-58903cf5122e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

