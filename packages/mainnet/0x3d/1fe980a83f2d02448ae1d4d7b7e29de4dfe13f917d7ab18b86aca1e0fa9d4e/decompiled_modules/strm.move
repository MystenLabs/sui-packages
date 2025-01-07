module 0x3d1fe980a83f2d02448ae1d4d7b7e29de4dfe13f917d7ab18b86aca1e0fa9d4e::strm {
    struct STRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRM>(arg0, 9, b"STRM", b"STORM", b"$Storm is a meme coin built on $SUI network and it is driven by social media hype and community support. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/481ac674-03e0-4ac5-91a8-6928549696ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

