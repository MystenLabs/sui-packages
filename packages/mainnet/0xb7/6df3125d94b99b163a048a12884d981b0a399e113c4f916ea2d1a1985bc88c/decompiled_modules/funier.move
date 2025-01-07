module 0xb76df3125d94b99b163a048a12884d981b0a399e113c4f916ea2d1a1985bc88c::funier {
    struct FUNIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNIER>(arg0, 9, b"FUNIER", b"Irony", b"The new meme of mr irony", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a02dfc4-db0a-4701-9381-8aee75717cbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

