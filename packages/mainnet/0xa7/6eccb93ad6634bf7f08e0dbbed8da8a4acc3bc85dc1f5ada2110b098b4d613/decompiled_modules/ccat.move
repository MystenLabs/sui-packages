module 0xa76eccb93ad6634bf7f08e0dbbed8da8a4acc3bc85dc1f5ada2110b098b4d613::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 9, b"CCAT", b"Coffe Cat", b"Coffe and cats meme every day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9b1177e-a2f7-48ab-9df1-9a6c237038ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

