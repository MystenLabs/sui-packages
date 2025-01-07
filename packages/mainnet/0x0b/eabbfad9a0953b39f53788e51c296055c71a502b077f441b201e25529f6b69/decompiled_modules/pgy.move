module 0xbeabbfad9a0953b39f53788e51c296055c71a502b077f441b201e25529f6b69::pgy {
    struct PGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGY>(arg0, 9, b"PGY", b"PIGGY", b"PIGGY MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0699e621-9192-4c91-889f-fe2f003a16c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

