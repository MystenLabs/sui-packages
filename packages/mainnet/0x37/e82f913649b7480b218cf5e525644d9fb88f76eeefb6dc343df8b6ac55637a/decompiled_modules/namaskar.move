module 0x37e82f913649b7480b218cf5e525644d9fb88f76eeefb6dc343df8b6ac55637a::namaskar {
    struct NAMASKAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMASKAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMASKAR>(arg0, 9, b"NAMASKAR", b"Vanya ", b"By Best meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb5c3dc4-1929-4b40-bbb5-1e7055ce3f04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMASKAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMASKAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

