module 0xc780d3110429f4a9d2d0aebde92b27c331980d55b4cbbbd2a990067b0912dc2b::wewewave {
    struct WEWEWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEWAVE>(arg0, 9, b"WEWEWAVE", x"205741564520f09f8c8a", b"Musayolameme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27ae4728-d7dd-4fac-876d-ab91ab7f45ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

