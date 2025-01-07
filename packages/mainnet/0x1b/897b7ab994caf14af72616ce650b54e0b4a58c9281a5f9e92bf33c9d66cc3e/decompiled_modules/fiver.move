module 0x1b897b7ab994caf14af72616ce650b54e0b4a58c9281a5f9e92bf33c9d66cc3e::fiver {
    struct FIVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVER>(arg0, 9, b"FIVER", b"XOD", b"This is a meme token. Very powerful token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22a2681a-290a-4242-b18e-bc09e6a86b65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

