module 0x3c9f56ac359237e6c0f5e54c017975cd1ce287b481c5400c79f686c3e17d8a00::daruntoken {
    struct DARUNTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARUNTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARUNTOKEN>(arg0, 9, b"DARUNTOKEN", b"Darun", b"Darun token meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9f8ecbf-1e2c-427d-a4d0-64616f50ff9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARUNTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARUNTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

