module 0x80ef629b7bbc0ac68a663eddca7412ed3e848fec929edb21383725f388344f17::ttr {
    struct TTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTR>(arg0, 9, b"TTR", b"Tech Tuber", b"New Crypto Live Now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34439dbd-fe6a-47e5-a07c-256cf87c7ab8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

