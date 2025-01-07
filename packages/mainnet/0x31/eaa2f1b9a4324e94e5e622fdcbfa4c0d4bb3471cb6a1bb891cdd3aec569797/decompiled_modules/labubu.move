module 0x31eaa2f1b9a4324e94e5e622fdcbfa4c0d4bb3471cb6a1bb891cdd3aec569797::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 9, b"LABUBU", b"Labubu Sui", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d26cf290-2b76-46ba-a3e0-69a8317e5605.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

