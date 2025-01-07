module 0xc6810ab0093ed61f73809610c2b4c2bc3152c1e4d894b2de47305abd1b732f9f::sht {
    struct SHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT>(arg0, 9, b"SHT", b"Shitmeme", b"Trade new meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5bd3a10-3bc1-4ea7-a302-5d6516d31013.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

