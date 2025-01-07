module 0xeda2b4979adf957f7ed84435e1332680500d099570a73596bf1f9fc7b7a6ba24::lola01 {
    struct LOLA01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA01>(arg0, 9, b"LOLA01", b"Lola", b"Fofun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c28a470-f654-4e8d-b18e-f2217ea632fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA01>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLA01>>(v1);
    }

    // decompiled from Move bytecode v6
}

